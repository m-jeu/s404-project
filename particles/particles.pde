Particle p;
PVector gravity;

void setup(){
  size(1920, 1080);
  
  p = new Particle(width / 2, height / 2);
  gravity = new PVector(0, 0.02);
}

void draw(){
  background(0, 0, 0);
  
  p.addForce(gravity);
  p.update();
  p.onScreen();
}
