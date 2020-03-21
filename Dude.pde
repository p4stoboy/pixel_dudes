class Block{
  PVector pos;
  PVector tile;
  int state;
  Dude parent;
  
  Block(Dude _parent, int _state, int _x, int _y, float _block_size){
    this.parent = _parent;
    this.state = _state;
    this.pos = new PVector();
    this.tile = new PVector();
    this.pos.x = this.parent.pos.x + _x * _block_size;
    this.pos.y = this.parent.pos.y + _y * _block_size;   
    this.tile.x = _x;
    this.tile.y = _y;
  }
  
  Boolean neighbours(){
    int x = int(this.tile.x);
    int y = int(this.tile.y);
     if((this.parent.cells[x][y].tile.x !=0 && this.parent.cells[x-1][y].state == 1) || (this.parent.cells[x][y].tile.x != this.parent.num_blocks-1 && this.parent.cells[x+1][y].state == 1) || (this.parent.cells[x][y].tile.y !=0 && this.parent.cells[x][y-1].state == 1) || (this.parent.cells[x][y].tile.y != this.parent.num_blocks-1 && this.parent.cells[x][y+1].state == 1)){
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
    this.pos = _pos;
    this.size = _size;
    this.num_blocks = _num_blocks;
    this.block_size = size/num_blocks;
    this.body_color = _col;
    this.outline_color = color(hue(body_color), saturation(body_color+50), 50);
    this.cells = new Block[num_blocks][num_blocks];
  }
  void generate(){
    for(int x = 0; x < this.num_blocks/2; x++){
      for(int y = 0; y < this.num_blocks; y++){
        int the_state = floor(random(0,1.9999));
        if(x == 0 || x == this.num_blocks -1 || y == 0 || y == this.num_blocks -1){
          the_state = 0;
        }
        this.cells[x][y] = new Block(this, the_state, x, y, this.block_size);
        this.cells[this.num_blocks-1-x][y] = new Block(this, this.cells[x][y].state, this.num_blocks-1-x, y, this.block_size);
        print(x);
        print(num_blocks-1-x);
      }
    }
    for(int x = 0; x < num_blocks; x++){
      for(int y = 0; y < num_blocks; y++){
       if(this.cells[x][y].state == 0 && this.cells[x][y].neighbours()){
         this.cells[x][y].state = 2;
       }
      }
    }
  }
  void display(){
    noStroke();
    for(int x = 0; x < this.num_blocks; x++){
      for(int y = 0; y < this.num_blocks; y++){
        switch(this.cells[x][y].state){
          case 1:
            fill(this.body_color);
            break;
          case 2: 
            fill(this.outline_color);
            break;
          default:
            fill(359);
            break;
        }
       rect(this.cells[x][y].pos.x, this.cells[x][y].pos.y, this.block_size, this.block_size);
     }
  }
  }

}
