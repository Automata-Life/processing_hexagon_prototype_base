class Hexagon {
  float x, y; // actual xy position
  int type, nextType;
  int i, j;
  
  Hexagon(int i, int j) {
    x = hexagonRadius * (3. / 2.) * j;
    y = hexagonRadius * sqrt(3.) * (i + 0.5 * (j % 2));
    
    

    type = nextType = 0;
    this.i = i;
    this.j = j;
  }
  
  Hexagon(Hexagon h) {
    this.x = h.x;
    this.y = h.y;
    this.type = h.type;
    this.nextType = h.nextType;
  }

  public void step() {
    type = nextType;
  }
  
  public void set(int i) {
    type = i;
  }
  
  public void setNext(int i) {
    nextType = i;
  }

  // display the hexagon at position xy with the current color
  // use the vertex positions that have been pre-calculated ONCE (instead of re-calculating these for each cell on each draw)
  void display() {
    pushMatrix();
    translate(x,y);

    setTypeColor(type);
    beginShape();
    for (int i = 0; i < 6; i++) {
      // Voodoo Magic
      vertex(v[i].x, v[i].y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}