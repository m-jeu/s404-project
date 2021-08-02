// FIXME(m-jeu): File name is quite confusing.


import java.util.ArrayList;

/**
A Particle in the particle system
*/
class Particle{
  private PVector location; /** Location as vector */
  private PVector velocity = new PVector(0, 0); /** Velocity as vector */
  
  // TODO(m-jeu): Consider immediatly adding it to an acceleration attribute instead of keeping track of backlog.
  /** All forced to be applied to compute a net acceleration upon next move */
  private ArrayList<PVector> forceBacklog = new ArrayList<PVector>();
  
  /** The particles mass */
  private int mass = 1;
  
  /** Construct with initial location */
  public Particle(PVector location){
    this.location = location;
  }
  
  /** Construct with x and y value */
  public Particle(int x, int y){
    this.location = new PVector(x, y);
  }
  
  /** Add a force to the force backlog to compute acceleration */
  public void addForce(PVector force){
    forceBacklog.add(force);
  }
  
  /** Take care of acceleration, velocity and location for one unit of time
  
  Uses forceBacklog to compute acceleration
  Uses acceleration to modify speed
  Uses speed to update location */
  public void update(){
    if(this.forceBacklog.size() != 0) { // If object is accelerating
      PVector acceleration = PVector.div(this.forceBacklog.get(0), this.mass);
      for(int i = 1; i < this.forceBacklog.size(); i++){
        PVector a = PVector.div(this.forceBacklog.get(i), this.mass);
        acceleration.add(a);
      }
      this.velocity.add(acceleration);
    }
    this.location.add(this.velocity);
  }
  
  /** Display the particle on screen */
  void onScreen(){
    noStroke();
    fill(254, 245, 218);
    ellipseMode(RADIUS); // Consider moving to setup()
    ellipse(this.location.x, this.location.y, 10, 10);
  }
}
