Particle p;
MassiveObject m;


void setup(){
  size(1920, 1080);
  frameRate(30);
  
  p = new Particle(width / 2, height / 2 - 200, 5, 0);
  m = new MassiveObject(width / 2, height / 2, 1000);
}

void draw(){
  background(0, 0, 0);
  
  m.attract(p);
  p.drag();
  p.update();
  p.onScreen();
  m.onScreen();
}
