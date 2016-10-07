public class Grid {
  Hexagon[][] hex_grid;
  int grid_height;
  int grid_width;
  
  public Grid(int new_grid_height, int new_grid_width) {
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
      
    for(int d = 0; d < 6; d++) {
      int neighbour_i = i + directions[parity][d][0];
      int neighbour_j = j + directions[parity][d][1];
      try{
        neighbours[d] = hex_grid[neighbour_i][neighbour_j];
      }
      catch(Exception e) {
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
  
  int[] _pixel_to_hex(int x, int y) {
    int hex_j = round(float(x) / (hexagonRadius * (3. / 2.)));
    int hex_i = round((y / hexagonRadius * sqrt(3.)) - (0.5 * (hex_j % 2)));
    
    int[] coord = {hex_i, hex_j};
    return coord;
  }
  
  Hexagon pixel_to_hex(int x, int y) {
    float min_dist = 10000000;
    float dist;
    Hexagon hex = null;
     for(int i = 0; i < grid_height; i++) {
        for(int j = 0; j < grid_width; j++) {
          dist = dist(hex_grid[i][j].x, hex_grid[i][j].y, x, y);
          if ( dist < min_dist){
            min_dist = dist;
            hex = hex_grid[i][j];
          }
        }
     }
     return hex;
  }
  
  int[] _old_pixel_to_hex(int y, int x) {
    //x = col
    //z = row - (col - (col&1)) / 2
    //y = -x-z

    float q = x * (2. / 3.) / (hexagonRadius + hexagonStroke/2);
    float r = ((-x / 3. )+ (sqrt(3.) / 3.) * y) / (hexagonRadius + hexagonStroke/2);
    
    float[] cube = {q, -q - r, r};
    
    print("x = " +cube[0]+ "| y = "+cube[1]+ "| z = " +cube[2]);
    return cube_to_hex(cube_round(cube));
  }
  
  int[] cube_round(float[] cube) {
    int rx = round(cube[0]);
    int ry = round(cube[1]);
    int rz = round(cube[2]);

    float x_diff = abs(rx - cube[0]);
    float y_diff = abs(ry - cube[1]);
    float z_diff = abs(rz - cube[2]);

    if (x_diff > y_diff && x_diff > z_diff)
        rx = -ry - rz;
    else if( y_diff > z_diff)
        ry = -rx - rz;
    else
        rz = -rx - ry;
    int[] rounded_cube = {rx, ry, rz}; 
    return rounded_cube;
  }
  
  int[] cube_to_hex(int[] cube){
    int q = cube[0];
    int r = cube[2];
    int[] hex = {q, r};
    
    hex[0] = q;
    hex[1] = r + (q - (q&1)) / 2;
    return hex;
  }
  
  Hexagon getHex(int x, int y) {
    return pixel_to_hex(x, y);
  }
}