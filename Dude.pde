class Block{
  PVector pos;
  PVector tile;
  int state;
  Dude parent;
  
  Block(Dude _parent, int _state, int _x, int _y, float _block_size){
    parent = _parent;
    state = _state;
    pos = new PVector();
    tile = new PVector();
    pos.x = parent.pos.x + _x * _block_size;
    pos.y = parent.pos.y + _y * _block_size;   
    tile.x = _x;
    tile.y = _y;
  }
  
  Boolean neighbours(){
    int x = int(tile.x);
    int y = int(tile.y);
     if((parent.cells[x][y].tile.x !=0 && parent.cells[x-1][y].state == 1) || (parent.cells[x][y].tile.x != parent.num_blocks-1 && parent.cells[x+1][y].state == 1) || (parent.cells[x][y].tile.y !=0 && parent.cells[x][y-1].state == 1) || (parent.cells[x][y].tile.y != parent.num_blocks-1 && parent.cells[x][y+1].state == 1)){
       return true;
     }
     else{
       return false;
     }
  }
}

class Dude{
  PVector pos;
  int size;
  int num_blocks;
  float block_size;
  color body_color;
  color outline_color;
  Block[][] cells;
  
  Dude(PVector _pos, int _size, int _num_blocks, color _col){
    pos = _pos;
    size = _size;
    num_blocks = _num_blocks;
    block_size = size/num_blocks;
    body_color = _col;
    outline_color = color(hue(body_color), saturation(body_color+50), 50);
    cells = new Block[num_blocks][num_blocks];
  }
  void generate(){
    for(int x = 0; x < floor((num_blocks+1)/2); x++){
      for(int y = 0; y < num_blocks; y++){
        int the_state = floor(random(0,1.9999));
        if(x == 0 || x == num_blocks -1 || y == 0 || y == num_blocks -1){
          the_state = 0;
        }
        cells[x][y] = new Block(this, the_state, x, y, block_size);
        if(x != (num_blocks-1)/2){
          cells[num_blocks-1-x][y] = new Block(this, cells[x][y].state, num_blocks-1-x, y, block_size);
        }
      }
    }
    for(int x = 0; x < num_blocks; x++){
      for(int y = 0; y < num_blocks; y++){
       if(cells[x][y].state == 0 && cells[x][y].neighbours()){
         cells[x][y].state = 2;
       }
      }
    }
  }
  void display(){
    noStroke();
    for(int x = 0; x < num_blocks; x++){
      for(int y = 0; y < num_blocks; y++){
        switch(cells[x][y].state){
          case 1:
            fill(body_color);
            break;
          case 2: 
            fill(outline_color);
            break;
          default:
            fill(359);
            break;
        }
       rect(cells[x][y].pos.x, cells[x][y].pos.y, block_size, block_size);
      }
    }
  }

}
