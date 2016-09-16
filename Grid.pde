class Grid {

  Hexagon [][] grid;
  int radius;
  long hash;
  
  Grid(int radius){
    this.radius = radius;
    grid = new Hexagon[radius][radius];
    for(int q = 0; q< radius; q++){
      for(int r = 0; r< radius; r++){
        grid[q][r] = new Hexagon(q,r);
      }
    }
  }
  
  void display(){
    for(int q = 0; q< radius; q++){
      for(int r = 0; r< radius; r++){
        grid[q][r].display();
      }
    }
  }
  
  void update(){
  }
  
}