void mouseDragged() { // Keep writing or erasing
  Hexagon h = grid.getHex(mouseX, mouseY);
  h.set(initial.type);
}

void mousePressed() { // Writes or erases

  initial = grid.getHex(mouseX, mouseY);
  
  initial.set(regra);
  mouseDragged();
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 7; j++){
      fill(255);
      survivalButtons[i][j].update();
      survivalButtons[i][j].pressed();
      birthButtons[i][j].update();
      birthButtons[i][j].pressed();
      SurvivalRules[i][j] = survivalButtons[i][j].pressed;
      BirthRules[i][j] = birthButtons[i][j].pressed;
    }
  }
}


void keyPressed() {
  if (key == ' ') {
    play = ! play;
  }
  if (key == 'r' || key == 'R'){
    grid.killAll();
    started = false;
    position_mode = 0;
    initGrid();
  }

  if (key == 'a' || key == 'A')
    regra = 0;
  if (key == 's' || key == 'S')
    regra = 1;
  if (key == 'd' || key == 'D')
    regra = 2;
  if (key == 'f' || key == 'F')
    regra = 3;
  if (key == 'm' && !started) {
    position_mode = 1;
    grid.randomize();
    started = true;
    // random
  }
  if (key == 'n' && !started) {
    position_mode = 0;
    started = true;
    // empty
  }
  if (key == CODED) {
    if (keyCode == RIGHT)
      step = true;
  }
}