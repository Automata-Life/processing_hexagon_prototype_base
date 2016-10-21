import processing.opengl.*; // the OpenGL library
import java.util.*;

float hexagonRadius = 20.; // the radius of the individual hexagon cell
float hexagonStroke = 3.; // stroke weight around hexagons (simulated! much faster than using the stroke() method)
int strokeColor = color(0); // stroke color around hexagons (simulated! much faster than using the stroke() method)
float neighbourDistance = hexagonRadius * 2; // the default distance to include up to 6 neighbours
int MAX_SCORE = 2000;
float MAX_PERCENTAGE = 0.6666;
int MAX_TURNS = 5;

boolean play = true;
boolean step = false;
boolean started = false;
int gameState = 1;
int end_state = 0;

int turn_ticks = 15;
int player_turn_duration = 10000;
int cells_per_turn = 30;
int inserted_cells = 0;


int player1_start;
int player2_start;

int[] score = new int[4];
float[] percentage = new float[4];
int[] cells = new int[4];
// 0 = not victorious
// 1 = score
// 2 = percentage
// 3 = turns
// 4 = cells
int victory_reason = 0;

boolean restart_iteration = false;

//0 -> empty
//1 -> random
//2 -> preset
int position_mode = 0;

Hexagon initial = null;
PVector box = new PVector(1000,1000);
int offsetX = 50;
int offsetY = 50;
int iteration = 1;

int color_palette = 1;
                                        
//Survives for 3 and 5 neighbours 
boolean[][] ConwaySurvivalRules = {{false,false,false,true,false, true, false},
                                 {false,false,false,true,false, true, false},
                                 {false,false,false,true,false, true, false}};  
                                 
boolean[][] SurvivalRules = ConwaySurvivalRules;

//Births only for 2 neighbours 
boolean[][] ConwayBirthRules = {{false,false,true,false,false, false, false},
                                {false,false,true,false,false, false, false},
                                {false,false,true,false,false, false, false}};  

boolean[][] BirthRules = ConwayBirthRules;

int grid_height = int(box.x / (hexagonRadius / 3)) + 2;
int grid_width  = int(box.y / (hexagonRadius / (sqrt(3) / 2))) + 3;
Grid grid = new Grid(grid_height, grid_width);

PVector[] v = new PVector[6];

void setup() {
  size(700, 700, P3D); // rendering with the OpenGL renderer is significantly faster when there is a lot of on-screen geometry
  noStroke(); // turn off stroke (for the rest of the sketch) since we use a much faster simulated stroke method
  smooth(); // turn on smooth(). Note that OpenGL smoothness usually depends on local graphics cards (aka anti-aliasing) settings
  initGrid(); // initialize the CA grid of hexagons (including neighbour search and creation of hexagon vertex positions)
  initGUI();
  frameRate(10);
}

void draw() {
  background(strokeColor); // background aka simulated stroke color
  if(!started) {
    fill(255);
    text("ARE YOU READY FOR BROA??!!", width/2 - 100, height/2);
    text("Aperte N para começar uma grid vazia", width/2 - 100, 20+height/2);
    text("Aperte M para começar uma grid aleatoria", width/2 - 100, 40+height/2);
  }
  else{
    if (play && end_state == 0){
      if (gameState == 0 && iteration % turn_ticks != 0) {
         iterate();
         delay(300);
         if (iteration % turn_ticks == 0) {
           restart_iteration = true;
         }
      }
      else if (restart_iteration) {
         iterate();
         delay(300);
         gameState = 1;
         restart_iteration = false;
         player1_start = millis();
         color_palette = 1;
         inserted_cells = 0;
         update_player_percentages();
         update_player_cells();
         end_state = game_ended();
      }
      if(gameState == 1) {
        if (player1_start == 0){
          player1_start = millis();
          inserted_cells = 0;
          color_palette = 1;
        }
        if(millis() - player1_start >= player_turn_duration) {
          // Player 2 Start
          gameState = 2;
          player2_start = millis();
          inserted_cells = 0;
          color_palette = 2;
        }
      }
      if(gameState == 2) {
        if (player2_start == 0){
          player2_start = millis();
          inserted_cells = 0;
          color_palette = 2;
        }
        if(millis()- player2_start >= player_turn_duration) {
          // Simulation Start
          gameState = 0;
          inserted_cells = 0;
        }
        
      }
      display();
    }
    else{
      play = false;
      background(0);
      fill(255);
      if(end_state == -1)
        text("EMPATE! " + victory_reason , width/2 - 100, height/2);
      else
        text("O JOGADOR " +end_state+ " GANHOU! " + victory_reason , width/2 - 100, height/2);
      
    }
    if (step) {
      iterate();
      step = false;
      display();
    }
    
  }
}

void update_player_percentages() {
  float cont_1, cont_2;
  float total;
  cont_1 = 0;
  cont_2 = 0;
  for (int i = 0; i < grid.grid_height; i++) {
    for (int j = 0; j < grid.grid_width; j++) {
      Hexagon h = grid.hex_grid[i][j];
      if (h.type == 1)
        cont_1++;
      else if(h.type == 2)
        cont_2++;
    }
  }
  total = grid.grid_height * grid.grid_width;
  percentage[1] = cont_1 / total;
  percentage[2] = cont_2 / total;
}

void update_player_cells() {
  int cont_1, cont_2;
  int total;
  cont_1 = 0;
  cont_2 = 0;
  for (int i = 0; i < grid.grid_height; i++) {
    for (int j = 0; j < grid.grid_width; j++) {
      Hexagon h = grid.hex_grid[i][j];
      if (h.type == 1)
        cont_1++;
      else if(h.type == 2)
        cont_2++;
    }
  }
  cells[1] = cont_1;
  cells[2] = cont_2;
}

void iterate() {
  iteration++;
  for (int i = 0; i < grid.grid_height; i++) {
    for (int j = 0; j < grid.grid_width; j++) {
      Hexagon h = grid.hex_grid[i][j];
      Hexagon[] neighbours = grid.getNeighbours(i,j);
      int[] count = grid.countNeighbours(neighbours);
      
      h.setNext(h.type);
      if (h.type > 0) {
        if(! SurvivalRules[h.type - 1][count[h.type]])  // death rule
          h.setNext(0);
      }
      else {
        for(int k = 3; k > 0; k--){
          if (BirthRules[k - 1][count[k]]){ // birth rule
            h.setNext(k);
            score[k]++;
            break;
          }
        }
      }
    }
  }
  grid.update();
}

public void display() {
  displayGUI();
}

int victory_score(boolean turns_ended){
  if (turns_ended || max(score) >= MAX_SCORE){
    if(score[1] > score[2])
      return 1;
    else if(score[2] > score[1])
      return 2;
    else
      return 0;
  }
  return 0;
}

int victory_percentage(boolean turns_ended){
  if (turns_ended || max(percentage) >= MAX_PERCENTAGE){
    if(percentage[1] > percentage[2])
      return 1;
    else if(percentage[2] > percentage[1])
      return 2;
    else
      return 0;
  }
  return 0;
}

int victory_turns(){
  boolean turns_ended = ((iteration/turn_ticks) + 1) >= MAX_TURNS;
  if (turns_ended){
    int winner = victory_percentage(turns_ended);
    if (winner != 0) {
      return winner;
    }
    winner = victory_score(turns_ended);
    if(winner != 0) {
      return winner;
    }
    return -1;
  }
  return 0;
}

int victory_cells() {
  boolean defeat1 = false;
  boolean defeat2 = false;
  if (cells[1] == 0) {
    defeat1 = true;
  }
  if (cells[2] == 0) {
    defeat2 = true;
  }
  if (defeat1 && defeat2) {
    return 0;
  }
  else if (defeat1) {
    return 2;
  }
  else if (defeat2) {
    return 1;
  }
  else{
    return 0;
  }
}

int game_ended() {
  int winner;
  
  winner = victory_turns();
  if (winner != 0) {
    victory_reason = 3;
    return winner;
  }
  
  winner = victory_cells();
  if (winner != 0) {
    victory_reason = 4;
    return winner;
  }

  winner = victory_percentage(false);
  if (winner != 0) {
    victory_reason = 2;
    return winner;
  }
  winner = victory_score(false);
  if (winner != 0) {
    victory_reason = 1;
    return winner;
  }
  
  return 0;
}

// do everything needed to start up the grid ONCE
void initGrid() {
  // create the vertex positions for the hexagon
  for (int i = 0; i < 6; i++) {
    float r = hexagonRadius - hexagonStroke / 2.; // adapt radius to facilitate the 'simulated stroke'
    float theta = i * PI / 3.;
    v[i] = new PVector(r * cos(theta), r * sin(theta));
  }
}