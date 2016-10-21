int windowBackground = color(128);
int windowStroke = color(255);
int buttonSize = 15;

CircleButton[][] survivalButtons = new CircleButton[3][7];
CircleButton[][] birthButtons = new CircleButton[3][7];

void initGUI(){
  pushMatrix();
  for(int i = 0; i < 3; i++)
    for(int j = 0; j< 7; j++){
      color SurvivalHigh = color(128,128,255);
      color SurvivalBase = color(255,128,128);
      color BirthHigh = color(128,128,255);
      color BirthBase = color(255,128,128);
      
      if (SurvivalRules[i][j]){
        color aux = SurvivalHigh;
        SurvivalHigh = SurvivalBase;
        SurvivalBase = aux;
      }
      
      if (BirthRules[i][j]){
        color aux = BirthHigh;
        BirthHigh = BirthBase;
        BirthBase = aux;
      }
      
      survivalButtons[i][j] = 
        new CircleButton((int)((1.0+j/2.0)*offsetX + 3.5*offsetX),
                         (int)(i*buttonSize + height - 6*offsetY/7 + hexagonStroke), 
                              buttonSize,
                              SurvivalBase,
                              SurvivalHigh , SurvivalRules[i][j]);

      birthButtons[i][j] = 
        new CircleButton((int)((6.0+j/2.0)*offsetX + 3.5*offsetX),
                         (int)(i*buttonSize + height - 6*offsetY/7 + hexagonStroke), 
                              buttonSize,
                              BirthBase,
                              BirthHigh, BirthRules[i][j]);
    }
    
  popMatrix();
}


void displayGUI(){
  grid.display();
  
  pushMatrix();
  textAlign(RIGHT,CENTER);
  margins(strokeColor);
  setTypeColor(color_palette);
  text("BRUSH:", 50, 10);
  rect(50,2,20,20);
  fill(255);
  text("TURNO " + ((iteration/turn_ticks) + 1), 300, 10);
  if (gameState == 0)
    text("RODANDO A BROA...", 500, 10);
  else{
    text("VEZ DO JOGADOR " + gameState, 700, 10);
    text("CELULAS RESTANTES: " + (cells_per_turn - inserted_cells) , 700, 30);
    if(gameState == 1)
      text("TEMPO RESTANTE: " + (player_turn_duration - millis() + player1_start)/1000 , 900, 30);
    else if(gameState == 2)
      text("TEMPO RESTANTE: " + (player_turn_duration - millis() + player2_start)/1000 , 900, 30);
  }
  text("PONTOS1: " + score[1], 300 , 30);
  text("PONTOS2: " + score[2], 500 , 30);
  
  translate(offsetX, height - offsetY + hexagonStroke);
  
  fill(windowBackground);
  rect(0, 0, width - 2*offsetX, offsetY);
  
  fill(windowStroke);
  text("Iteration: "+(iteration-1),1.5*offsetX, 2*hexagonStroke);
  
  translate(2.5*offsetX,offsetY/7);
  popMatrix();
  if (gameState == 0 || gameState == 1)
    text("S RED:",survivalButtons[0][0].x - buttonSize, survivalButtons[0][0].y);
  if (gameState == 0 || gameState == 2)
    text("S GREEN:",survivalButtons[0][0].x - buttonSize, survivalButtons[1][0].y);
  //text("S BLUE:",survivalButtons[0][0].x - buttonSize, survivalButtons[2][0].y);
  if (gameState == 0 || gameState == 1)
    text("B RED:",birthButtons[0][0].x - buttonSize, birthButtons[0][0].y);
  if (gameState == 0 || gameState == 2)
    text("B GREEN:",birthButtons[0][0].x - buttonSize, birthButtons[1][0].y);
  //text("B BLUE:",birthButtons[0][0].x - buttonSize, birthButtons[2][0].y);
  
  displayButtons();
}

void margins(int colour){
  fill(colour);
  rect(0,0,width,offsetY);
  rect(0,0,offsetX,height);
  rect(0,height-offsetY,width,offsetY);
  rect(width-offsetX,0,offsetX,height);
}

void button(float x,float y, boolean state){
  pushStyle();
  ellipseMode(CORNER);
  stroke(windowStroke);
  strokeWeight(buttonSize/5);
  fill(windowBackground);
  if(state)
    fill(strokeColor);
  ellipse(x,y,buttonSize,buttonSize);
  popStyle();
}

void displayButtons(){
  int i = gameState -1 ;
  if(gameState == 0) {
    for(i = 0; i < 2; i++){ 
      for(int j = 0; j < 7; j++){
        survivalButtons[i][j].update();
        birthButtons[i][j].update();
        survivalButtons[i][j].display();
        birthButtons[i][j].display();
      }
    }
  }
  else{
    for(int j = 0; j < 7; j++){
      survivalButtons[i][j].update();
      birthButtons[i][j].update();
      survivalButtons[i][j].display();
      birthButtons[i][j].display();
    }
  }
}

void setTypeColor(int type){
      switch(type){
      case(1):
        fill(255,0,0);
        break;
      case(2):
        fill(0,255,0);
        break;
      case(3):
        fill(0,0,255);
        break;
      default:
        fill(128);
    }
}