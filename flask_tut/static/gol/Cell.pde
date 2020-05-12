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
