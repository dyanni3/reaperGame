class Cell{
  
  int x;
  int y;
  int state; //0 for empty, 1 for filled, 2 for hot
  
  
  Cell(int tempx, int tempy, int tempstate){
    x=tempx;
    y=tempy;
    state=tempstate;
  }
  
  //method for cell to display itself
  void show(int cellSize){
    stroke(100);
    if(state==1){
      fill(0, 200, 0);}
    else if(state==2){ //to show hot cells
      float r=155;
      float b=20;
      fill(r,0,b);//show hot cells
    }
    else{
      fill(0);
    }
    rect(x*cellSize,y*cellSize,cellSize,cellSize);
  }
}

//Global variables...
Cell[][] cells;
int num_cells=50;
int cellSize=10;
int running=1; //if set to 0 everything pauses
int[][] rules;
int[][] new_cells;
int ssr = 0;


//initial setup
void setup(){
  frameRate(30);
  size(600,500);
  background(0);
  cells=new Cell[num_cells][num_cells];
  rules = new int[2][3];
  new_cells = new int[num_cells][num_cells];
  for (int y = 0; y < num_cells; y++) {
    for (int x = 0; x < num_cells; x++) {
      cells[x][y] = new Cell(x,y,0);
      new_cells[x][y] = 0;
   }
 }
 for (int i=0; i<2; i++){
   for (int j=0; j<2; j++){
     rules[i][j] = 0;
   }
 }
}


//used for re-seeding the simulation mid-run same as initial setup routine but without specifying screen size etc.
void re_setup(){
  cells=new Cell[num_cells][num_cells];
  for (int y = 0; y < num_cells; y++) {
    for (int x = 0; x < num_cells; x++) {
      cells[x][y]= new Cell(x,y,0);
   }
 }
}

void show(){
      for (int y0=0;y0<num_cells; y0++){
      for (int x0=0; x0<num_cells; x0++){
        cells[x0][y0].show(cellSize);
      }
    }
}

void draw(){
  //if(running==1){
  //   for (int y=0;y<num_cells; y++){
  //    for (int x=0; x<num_cells; x++){
  //      cells[x][y].show(cellSize);
  //    }
  //  }
  // }
  show();
  //show current rules green sow and red reap
  for (int i=0; i<2; i++){
   for (int j=0; j<3; j++){
     if (i==0){
       fill(0,rules[i][j]*155,0);
     }
     else{
       fill(rules[i][j]*155,0,0);
     }
     stroke(100);
     rect(530 + j*cellSize, 10 + i*cellSize, cellSize, cellSize);
   }
 }
}

void mousePressed(){
  int x = floor( min(mouseX,499)/cellSize);
  int y = floor( min(mouseY, 499)/cellSize);
  print(x);
  cells[x][y].state = 1 - cells[x][y].state;
}

// fill in sow and reap functions
void seed(){
    for (int y = num_cells-1; y > 0; y--) {
        for (int x = 0; x < num_cells; x++) {
        if(cells[x][y].state==1){
          cells[pb(x-1)][y-1].state = (int)(cells[pb(x-1)][y-1].state ^ rules[0][0]);
          cells[pb(x)][y-1].state = (int)(cells[pb(x)][y-1].state ^ rules[0][1]);
          cells[pb(x+1)][y-1].state = (int)(cells[pb(x+1)][y-1].state ^ rules[0][2]);
        }   
     }
   }
   for (int x = 0; x < num_cells; x++){
     cells[x][num_cells-1].state=0;
     cells[x][0].state=0;
   }
 }
 
void take_time(int time){
  for(int i=0; i<time; i++){
    ;
  }
}
  
// fill in sow and reap functions
void sow(){
    for (int y = num_cells-1; y >= 0; y--) {
      for (int x = 0; x < num_cells; x++) {
        boolean matches = true;
        for( int xit = -1; xit<2; xit++){
          if(cells[pb(x+xit)][y].state != rules[1][xit+1]){
            matches = false;
          }
        }
        if(matches){
          new_cells[x][y] = 2;
        }
        else{
          new_cells[x][y] = cells[x][y].state;
        }
      }
    }
    for (int y = num_cells-1; y > 0; y--) {
      for (int x = 0; x < num_cells; x++) {
        cells[x][y].state = new_cells[x][y];
      }
    }  
}

void reap(){
  for (int y = num_cells-1; y >= 0; y--) {
    for (int x = 0; x < num_cells; x++) {
      if(cells[x][y].state==2){
        cells[x][y].state=0;
      }
    }
  }
}

void keyPressed(){
//space bar - Start or stop the pattern growth (toggle between these).
//i - reinitialize.
  if(key==32){
    //running=1-running;
    if(ssr == 0){
      seed();
      ssr++;
    }
    else if(ssr==1){
      sow();
      ssr++;
    }
    else{
      reap();
      ssr = 0;
    }
  }
  
  if(key=='1'){
    rules[0][0] = 1-rules[0][0];
  }
  if(key=='2'){
    rules[0][1] = 1-rules[0][1];
  }
  if(key=='3'){
    rules[0][2] =1-rules[0][2];
  }
  if(key=='4'){
    rules[1][0] = 1-rules[1][0];
  }
  if(key=='5'){
    rules[1][1] = 1-rules[1][1];
  }
  if(key=='6'){
    rules[1][2] =1-rules[1][2];
  }  

  if(key=='i'){
    re_setup();
  }
  
  // if key equals for rules
}

int pb(int z){
  return((z+num_cells)%num_cells);
}
