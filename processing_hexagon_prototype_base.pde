import processing.opengl.*; // the OpenGL library
import java.util.*;

float hexagonRadius = 20.; // the radius of the individual hexagon cell
float hexagonStroke = 3.; // stroke weight around hexagons (simulated! much faster than using the stroke() method)
int strokeColor = color(0); // stroke color around hexagons (simulated! much faster than using the stroke() method)
float neighbourDistance = hexagonRadius * 2; // the default distance to include up to 6 neighbours

boolean play = false;
boolean step = false;
Hexagon initial = null;
PVector box = new PVector(1000,1000);
int offsetX = 50;
int offsetY = 50;
int iteration;

int regra = 1;
boolean[][] SurvivalRules = new boolean[3][7];

boolean[][] BirthRules = new boolean[3][7];

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
  if (play)
    iterate();
  if (step) {
    iterate();
    step = false;
  }
  display();
}

void iterate() {
  iteration++;
  for (int i = 0; i < grid.grid_height; i++) {
    for (int j = 0; j < grid.grid_width; j++) {
      Hexagon h = grid.hex_grid[i][j];
      int[] count = {0, 0, 0, 0};
      Hexagon[] neighbours = grid.getNeighbours(i,j);
      for(Hexagon n : neighbours)
        if(n != null)
          count[n.type]++;
      
      h.setNext(h.type);
      if (h.type > 0) {
        if(! SurvivalRules[h.type - 1][count[h.type]])  // death rule
          h.setNext(0);
      }
      else {
        for(int k = 3; k > 0; k--){
          if (BirthRules[k - 1][count[k]]){ // birth rule
            h.setNext(k);
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



// do everything needed to start up the grid ONCE
void initGrid() {
  // create the vertex positions for the hexagon
  for (int i = 0; i < 6; i++) {
    float r = hexagonRadius - hexagonStroke / 2.; // adapt radius to facilitate the 'simulated stroke'
    float theta = i * PI / 3.;
    v[i] = new PVector(r * cos(theta), r * sin(theta));
  }
}