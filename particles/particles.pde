import java.util.ArrayList;


ArrayList<Particle> particles;
ArrayList<MassiveObject> mobjects;


void setup(){
  size(1920, 1080);
  frameRate(30);
  
  CharacterRepresentation
  
  mobjects = new ArrayList<MassiveObject>();
  ArrayList<PVector> mCoords = CharacterRepresentation.getRepr(Character.valueOf('S'), new PVector(width / 2, height / 2));
  for(PVector coord: mCoords){
    mobjects.add(new MassiveObject(coord, 800));
  }
  
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
    p.visualizeCloseParticles(particles, 60);
  }
  for(MassiveObject m: mobjects){
    m.onScreen();
  }
}

void mousePressed(){
  mobjects.add(new MassiveObject(mouseX, mouseY, 800));
}
