//  Dude(PVector _pos, int _size, int _num_blocks)
ArrayList<Dude> dudes;

void setup(){
  colorMode(HSB, 360, 100, 100);
  dudes = new ArrayList<Dude>();
  size(1210,1210);
  background(359);
  int hue = 0;
  for(int x = 5; x < 1205; x+=50){
    for(int y = 5; y < 1205; y+=50){
      Dude the_dude = new Dude(new PVector(x,y), 50, 6, color(hue,35,100));
      hue++;
      if(hue>359){
        hue = 0;
      }
      the_dude.generate();
      dudes.add(the_dude);
    }
  }
}

void draw(){
  for(Dude d: dudes){
    d.display();
  }
}

void mousePressed(){
  dudes.clear();
  setup();
}
