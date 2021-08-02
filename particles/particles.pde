import java.util.ArrayList;


ArrayList<Particle> particles;
ArrayList<MassiveObject> mobjects;


void setup(){
  size(1920, 1080);
  frameRate(30);
  
  particles = new ArrayList<Particle>();
  mobjects = new ArrayList<MassiveObject>();
  
  for(int i = 0; i < 100; i++){
    particles.add(new Particle(width / 2 + (i * 5), height / 2));
  }
}

void draw(){
  background(0, 0, 0);
  for(MassiveObject m: mobjects){
    for(Particle p: particles){
      m.attract(p);
    }
  }
  for(Particle p: particles){
    p.drag();
    p.update();
    p.onScreen();
  }
  for(MassiveObject m: mobjects){
    m.onScreen();
  }
}

void mousePressed(){
  mobjects.add(new MassiveObject(mouseX, mouseY, 1000));
}
