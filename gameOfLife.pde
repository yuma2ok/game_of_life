int[][] cell;
int[][] temp;
int w, h;
int cell_size = 5;
int numX, numY;

void setup(){
  size(800, 600);
  w = width;
  h = height;
  numX = w / cell_size;
  numY = h / cell_size;
  
  cell = new int [numX + 2][numY + 2];
  temp = new int [numX + 2][numY + 2];
  
  cell = setCell(cell, numX, numY);
  
  noStroke();
  frameRate(60);
  
  background(255);
}

void draw(){
  
  drawCell(cell, numX, numY, cell_size);
  
  for(int x = 1; x < numX; x ++){
    for(int y = 1; y < numY; y++){
      int[] states = getStates(cell, x, y);
      temp[x][y] = updateCell(states);
    }
  }
  
  for(int x = 1; x < numX; x ++){
    for(int y = 1; y < numY; y++){
      cell[x][y] = temp[x][y];
    }
  }
  
}

int[][] setCell(int[][] cell, int numX, int numY){
 for(int x = 0; x < numX+2; x ++){
    for(int y = 0; y < numY+2; y++){
      float n = random(1);
      if(n > 0.7){
        cell[x][y] = 1;
      }else{
        cell[x][y] = 0;
      }
    }
  }
  return cell;
}

void drawCell(int[][] cell, int numX, int numY, int cell_size){
  for(int x = 1; x < numX+1; x ++){
    for(int y = 1; y < numY+1; y++){
      int posX = (x-1)*cell_size;
      int posY = (y-1)*cell_size;
      if(cell[x][y] == 1){
        fill(0);
      }else{
        fill(255);
      }
      rect(posX, posY, cell_size, cell_size);
    }
  }
}

int[] getStates(int[][] cell, int x, int y){
  int[] states = new int[9];
  states[0] = cell[x][y];
  
  states[1] = cell[x-1][y-1];
  states[2] = cell[x][y-1];
  states[3] = cell[x+1][y-1];
  
  states[4] = cell[x-1][y];
  states[5] = cell[x+1][y];
  
  states[6] = cell[x-1][y+1];
  states[7] = cell[x][y+1];
  states[8] = cell[x+1][y+1];
  
  return states;
}

int updateCell(int[] states){
  int aliveNum = 0;
  for (int i = 1; i < 9; i ++){
    aliveNum += states[i];
  }
  if(aliveNum == 2){
    return states[0];
  }else if(aliveNum == 3){
    return 1;
  }else{
    return 0;
  }
}
