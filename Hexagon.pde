class Hexagon {
  float x, y; // actual xy position
  boolean state, nextState;
  ArrayList <Hexagon> neighbours = new ArrayList <Hexagon> (); // arrayList to store the neighbours

  Hexagon(int i, int j) {
    x = offsetX + 3*hexagonRadius*(i+((j%2==0)?0:0.5f)); // calculate the actual x position within the sketch window
    y = offsetY + 0.866f*hexagonRadius*j; // calculate the actual y position within the sketch window
    state = nextState = false;
  }
  
  Hexagon(Hexagon h){
    this.x = h.x;
    this.y = h.y;
    this.state = h.state;
    this.nextState = h.nextState;
  }

  public void step() {
    state = nextState;
  }
  
  public void set(boolean b){
    state = b;
  }
  
  public void setNext(boolean b){
    nextState = b;
  }

  // given a distance parameter, this will add all the neighbours within range to the list
  void getNeighbours(float distance, ArrayList <Hexagon> grid) {
    // neighbours.clear(); // in this sketch not required because neighbours are only searched once
    for (Hexagon h : grid) { // for all the cells in the grid
      if (h!=this) { // if it's not the cell itself
        if (dist(x,y, h.x,h.y) < distance) { // if it's within distance
          neighbours.add( h ); // then add it to the list: "Welcome neighbour!"
        }
      }
    }
  }

  // display the hexagon at position xy with the current color
  // use the vertex positions that have been pre-calculated ONCE (instead of re-calculating these for each cell on each draw)
  void display() {
    pushMatrix();
    translate(x, y);
    if(state) fill(255);
    else    fill(128);
    beginShape();
    for (int i=0; i<6; i++) { vertex(v[i].x, v[i].y); }
    endShape();
    popMatrix();
  }
}