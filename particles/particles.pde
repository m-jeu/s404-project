import com.hamoid.*;

import java.util.ArrayList;


ArrayList<Particle> particles;
ArrayList<MassiveObject> mobjects;

PImage backGround;

VideoExport videoExport;


void setup(){
  // Screen setup
  size(1920, 1080);
  frameRate(30);
  
  backGround = loadImage("background.jpg");
  
  // Video export setup
  
  videoExport = new VideoExport(this, "MaartenDeJeu.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  
  // Object setup
  
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
  
  particles = spawnParticles(150, 20);
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
  
  // Video export
  videoExport.saveFrame();
}


// Video shutdown
void keyPressed(){
  if(key == 'q'){
    videoExport.endMovie();
    exit();
  }
}
