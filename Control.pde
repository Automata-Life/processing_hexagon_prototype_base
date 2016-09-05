void mouseDragged() { // Keep writing or erasing
  Hexagon h = getHex(mouseX, mouseY);
  h.set(initial.state);
}

void mousePressed() { // Writes or erases
  initial = getHex(mouseX, mouseY);
  initial.set(!initial.state);
  mouseDragged();
}

void keyPressed() {
  if (key == ' ') {
    play = ! play;
  }
  if (key == 'r' || key == 'R')
    initGrid();
  if (key == CODED) {
    if (keyCode == RIGHT)
      step = true;
  }
}