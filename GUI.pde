void displayGUI(){
  fill(0);
  rect(0,0,width,offsetY);
  rect(0,0,offsetX,height);
  rect(0,height-offsetY,width,offsetY);
  rect(width-offsetX,0,offsetX,height);
  fill(255);
  text("Iteration: "+iteration,offsetX, height-offsetY/2);
  fill(128);
  rect(5*offsetX,height-2.6*offsetY/3,5.5*offsetX,offsetX/3);
  fill(255);
  text("Survival Rules: ",5*offsetX, height-2*offsetY/3);
  for(int i = 0; i < 7; i++){
    if(SurvivalRules[i])
      fill(0);
    else
      fill(255);
    ellipse((7.0+i/2.0)*offsetX,height-1.5*offsetY/3 - offsetX/5, offsetX/3, offsetX/3);
  }
  
  translate(0,offsetX/3);
  
  fill(128);
  rect(5*offsetX,height-2.6*offsetY/3,5.5*offsetX,offsetX/3);
  fill(255);
  text("Birth Rules: ",5*offsetX, height-2*offsetY/3);
  for(int i = 0; i < 7; i++){
    if(BirthRules[i])
      fill(0);
    else
      fill(255);
    ellipse((7.0+i/2.0)*offsetX,height-1.5*offsetY/3 - offsetX/5, offsetX/3, offsetX/3);
  }
}