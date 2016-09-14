int windowBackground = color(128);
int windowStroke = color(255);
int buttonSize = 15;

void displayGUI(){
  displayGrid();
  margins(strokeColor);
  switch(regra){
    case(0):
      fill(255,0,0);
      break;
    case(1):
      fill(0,255,0);
      break;
    case(2):
      fill(0,0,255);
      break;
  }
  rect(0,0,20,20);
  
  textAlign(LEFT,TOP);
  translate(offsetX, height - offsetY + hexagonStroke);
  
  fill(windowBackground);
  rect(0,0,width - 2*offsetX,offsetY - 2*hexagonStroke);
  
  fill(windowStroke);
  text("Iteration: "+iteration,offsetX, 0);
  
  translate(2.5*offsetX,0);
  text("Survival Rules: ",0, 0);
  
  fill(windowBackground);
  
  for(int i = 0; i < 3; i++)
    for(int j = 0; j< 7; j++)
      button((2.0+j/2.0)*offsetX, i*buttonSize, SurvivalRules[i][j]);
  // button((2.0+i/2.0)*offsetX, 0, SurvivalRules[i]);
  
  translate(4*offsetX,0);
  
  fill(255);
  text("Birth Rules: ",0, 0);
  for(int i = 0; i < 3; i++)
    for(int j = 0; j< 7; j++)
      button((2.0+j/2.0)*offsetX, i*buttonSize, BirthRules[i][j]);
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

void displayGrid(){
  for (Hexagon h : grid)
    h.display();
}