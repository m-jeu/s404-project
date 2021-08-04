import java.util.ArrayList;


ArrayList<Particle> particles;
ArrayList<MassiveObject> mobjects;


void setup(){
  size(1920, 1080);
  frameRate(30);
  
  mobjects = new ArrayList<MassiveObject>();
  
  particles = spawnParticles(100, 20);
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
    p.wrapAround();
    p.onScreen();
    p.visualizeCloseParticles(particles, 30);
  }
  for(MassiveObject m: mobjects){
    m.onScreen();
  }
}

void mousePressed(){
  mobjects.add(new MassiveObject(mouseX, mouseY, 800));
}
