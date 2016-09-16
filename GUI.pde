int windowBackground = color(128);
int windowStroke = color(255);
int buttonSize = 15;

CircleButton[][] survivalButtons = new CircleButton[3][7];
CircleButton[][] birthButtons = new CircleButton[3][7];


void initGUI(){
  pushMatrix();
  for(int i = 0; i < 3; i++)
    for(int j = 0; j< 7; j++){
      survivalButtons[i][j] = 
        new CircleButton((int)((1.0+j/2.0)*offsetX + 3.5*offsetX),
                         (int)(i*buttonSize + height - 6*offsetY/7 + hexagonStroke), 
                              buttonSize,
                              color(128,128,255),
                              color(255,128,128), SurvivalRules[i][j]);

      birthButtons[i][j] = 
        new CircleButton((int)((6.0+j/2.0)*offsetX + 3.5*offsetX),
                         (int)(i*buttonSize + height - 6*offsetY/7 + hexagonStroke), 
                              buttonSize,
                              color(128,255,128),
                              color(255,128,255), BirthRules[i][j]);
    }
    
  popMatrix();
}


void displayGUI(){
  displayGrid();
  
  pushMatrix();
  textAlign(RIGHT,CENTER);
  margins(strokeColor);
  setTypeColor(regra);
  text("BRUSH:", 50, 10);
  rect(50,2,20,20);
  
  translate(offsetX, height - offsetY + hexagonStroke);
  
  fill(windowBackground);
  rect(0,0,width - 2*offsetX,offsetY);
  
  fill(windowStroke);
  text("Iteration: "+iteration,1.5*offsetX, 2*hexagonStroke);
  
  translate(2.5*offsetX,offsetY/7);
  popMatrix();

  text("S RED:",survivalButtons[0][0].x - buttonSize, survivalButtons[0][0].y);
  text("S GREEN:",survivalButtons[0][0].x - buttonSize, survivalButtons[1][0].y);
  text("S BLUE:",survivalButtons[0][0].x - buttonSize, survivalButtons[2][0].y);
  
  text("B RED:",birthButtons[0][0].x - buttonSize, birthButtons[0][0].y);
  text("B GREEN:",birthButtons[0][0].x - buttonSize, birthButtons[1][0].y);
  text("B BLUE:",birthButtons[0][0].x - buttonSize, birthButtons[2][0].y);
  
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
  for(int i = 0; i < 3; i++){
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

void displayGrid(){
  for (Hexagon h : grid)
    h.display();
}