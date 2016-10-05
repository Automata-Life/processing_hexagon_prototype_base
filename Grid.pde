public class Grid {
  Hexagon[][] hex_grid;
  int grid_height;
  int grid_width;
  
  public Grid(int new_grid_height, int new_grid_width){
    grid_height = new_grid_height;
    grid_width = new_grid_width;
    hex_grid = new Hexagon[grid_height][grid_width];
    for(int i = 0; i < grid_height; i++) {
      for(int j = 0; j < grid_width; j++) {
        hex_grid[i][j] = new Hexagon(i,j);
      }
    }
  }
  
  Hexagon[] getNeighbours(int i, int j) {
    Hexagon[] neighbours = new Hexagon[6];
    int parity = j & 1;
    
    int[][][] directions = 
      {
        {{-1,-1},{0,-1},{1,-1},{1,0},{0,1},{-1,0}},
        {{-1,0}, {0,-1},{1,0}, {1,1},{0,1},{-1,1}}
      };
      
    for(int d = 0; d < 6; d++){
      int neighbour_i = i + directions[parity][d][0];
      int neighbour_j = j + directions[parity][d][1];
      try{
        neighbours[d] = hex_grid[neighbour_i][neighbour_j];
      }
      catch(Exception e){
        neighbours[d] = null;
      }
    }
    return neighbours;
  } 
  
  void display() {
    for(int i = 0; i < grid_height; i++) {
      for(int j = 0; j < grid_width; j++) {
        hex_grid[i][j].display();
      }
    }
  }
  
  void update() {
    for(int i = 0; i < grid_height; i++) {
      for(int j = 0; j < grid_width; j++) {
        hex_grid[i][j].step();
      }
    }
  }
}