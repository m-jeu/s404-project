Particle p;
MassiveObject m;


void setup(){
  size(1920, 1080);
  
  p = new Particle(width / 2, height / 2);
  m = new MassiveObject(width / 2, height / 2 - 100, 100);
}

void draw(){
  background(0, 0, 0);
  
  m.attract(p);
  p.update();
  p.onScreen();
  m.onScreen();
}
