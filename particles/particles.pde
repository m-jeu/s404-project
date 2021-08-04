import java.util.ArrayList;


ArrayList<Particle> particles;
ArrayList<MassiveObject> mobjects;

PImage backGround;


void setup(){
  size(1920, 1080);
  frameRate(30);
  
  backGround = loadImage("background.jpg");
  
  CharacterRepresentation.initCoordinates();
  
  mobjects = new ArrayList<MassiveObject>();
  ArrayList<PVector> sCoords = CharacterRepresentation.getRepr(Character.valueOf('S'), new PVector(width / 2 + 200, height / 2));
  ArrayList<PVector> dCoords = CharacterRepresentation.getRepr(Character.valueOf('d'), new PVector(width / 2 - 200, height / 2));
  for(PVector coord: sCoords){
    mobjects.add(new MassiveObject(coord, 800));
  }
    for(PVector coord: dCoords){
    mobjects.add(new MassiveObject(coord, 1200));
  }
  
  particles = spawnParticles(100, 20);
}

void draw(){
  //background(0, 0, 0);
  background(backGround);
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
    p.visualizeCloseParticles(particles, 110, true);
  }
  for(MassiveObject m: mobjects){
    m.onScreen();
  }
}

void mousePressed(){
  mobjects.add(new MassiveObject(mouseX, mouseY, 800));
}
