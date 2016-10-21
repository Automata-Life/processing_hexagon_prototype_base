void mouseDragged() { // Keep writing or erasing
  Hexagon h = grid.getHex(mouseX, mouseY);
  if(color_palette == 0){
    if (h.type == gameState){
      inserted_cells -= 1;
      h.set(0);
    }
  }
  else {
    if (h.type == 0 && inserted_cells < cells_per_turn){
      inserted_cells += 1;
      h.set(color_palette);
    }
  }

}

void mousePressed() { // Writes or erases
  initial = grid.getHex(mouseX, mouseY);
    
  if(color_palette == 0){
    if (initial.type == gameState){
      inserted_cells -= 1;
      initial.set(0);
    }
  }
  else {
    if (initial.type == 0 && inserted_cells < cells_per_turn){
      inserted_cells += 1;
      initial.set(color_palette);
    }
  }
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

  if (key == 'a' || key == 'A' && gameState > 0)
    color_palette = (color_palette == 0) ? gameState : 0;
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