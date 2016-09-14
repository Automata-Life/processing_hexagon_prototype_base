void mouseDragged() { // Keep writing or erasing
  Hexagon h = getHex(mouseX, mouseY);
  h.set(initial.type);
}

void mousePressed() { // Writes or erases
  initial = getHex(mouseX, mouseY);
  initial.set((initial.type +1)%4);
  mouseDragged();
}

void keyPressed() {
  if (key == ' ') {
    play = ! play;
  }
  if (key == 'r' || key == 'R')
    initGrid();

  if (key == 'i' || key == 'I')
    regra = 0;
  if (key == 'o' || key == 'O')
    regra = 1;
  if (key == 'p' || key == 'P')
    regra = 2;
    
    
  if (key == 'a' || key == 'A')
    SurvivalRules[regra][0] = ! SurvivalRules[regra][0];
  if (key == 's' || key == 'S')
    SurvivalRules[regra][1] = ! SurvivalRules[regra][1];
  if (key == 'd' || key == 'D')
    SurvivalRules[regra][2] = ! SurvivalRules[regra][2];
  if (key == 'f' || key == 'F')
    SurvivalRules[regra][3] = ! SurvivalRules[regra][3];
  if (key == 'g' || key == 'G')
    SurvivalRules[regra][4] = ! SurvivalRules[regra][4];
  if (key == 'h' || key == 'H')
    SurvivalRules[regra][5] = ! SurvivalRules[regra][5];
  if (key == 'j' || key == 'J')
    SurvivalRules[regra][6] = ! SurvivalRules[regra][6];
  
  if (key == '0')
    BirthRules[regra][0] = ! BirthRules[regra][0];
  if (key == '1')
    BirthRules[regra][1] = ! BirthRules[regra][1];
  if (key == '2')
    BirthRules[regra][2] = ! BirthRules[regra][2];
  if (key == '3')
    BirthRules[regra][3] = ! BirthRules[regra][3];
  if (key == '4')
    BirthRules[regra][4] = ! BirthRules[regra][4];
  if (key == '5')
    BirthRules[regra][5] = ! BirthRules[regra][5];
  if (key == '6')
    BirthRules[regra][6] = ! BirthRules[regra][6];
  
  if (key == CODED) {
    if (keyCode == RIGHT)
      step = true;
  }
}