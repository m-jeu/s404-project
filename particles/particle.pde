// FIXME(m-jeu): File name is quite confusing.


import java.util.ArrayList;


/** An object with mass */
interface ObjectWithMass{
  public int getMass();
}

/** An object that can be drawn on the screen */
interface ScreenObject{
  
  /** Draw the object on the screen */
  public void onScreen();
}


/** An object around which particles orbit
It has mass to compute gravitational attraction with, but is immovable*/
class MassiveObject implements ObjectWithMass, ScreenObject{
  private PVector location; // TODO(m-jeu) consider combining in one baseclass with particle
  private int mass;
  
  private static final float G = 1; // Universal gravitation constant (times 1/2)
  private static final float GRAV_DIST_LOWER_LIMIT = 20.0; // The lower limit distance will be constrained to for the purpose of attraction, to erratic behaviour
  private static final float GRAV_DIST_UPPER_LIMIT = 100.0; // ^  upper ^
  
  public int getMass(){
    return this.mass;
  }
  
  // Construct with location as PVector, and mass
  public MassiveObject(PVector location, int mass){
    this.location = location;
    this.mass = mass;
  }
  
  // Construct with location as x and y coordinate, and mass
  public MassiveObject(int x, int y, int mass){
    this(new PVector(x, y), mass);
  }
  
  /** Compute gravitational attraction towards a certain particle, and apply it to that particle */
  public void attract(Particle p){
    PVector dif = PVector.sub(this.location, p.location);
    float distance = dif.mag();
    distance = constrain(distance, GRAV_DIST_LOWER_LIMIT, GRAV_DIST_UPPER_LIMIT);
    float strength = (MassiveObject.G * this.mass * p.getMass()) / (distance * distance);
    
    dif.normalize();
    dif.mult(strength);
    
    p.addForce(dif);
  }
  
  // Display the object on screen
  public void onScreen(){
    noStroke();
    fill(254, 0, 0);
    ellipseMode(RADIUS); // Consider moving to setup()
    ellipse(this.location.x, this.location.y, 5, 5);
  }
}


/**
A Particle in the particle system
*/
class Particle implements ObjectWithMass, ScreenObject{
  private PVector location; /** Location as vector */
  private PVector velocity = new PVector(0, 0); /** Velocity as vector */
  
  // TODO(m-jeu): Consider immediatly adding it to an acceleration attribute instead of keeping track of backlog.
  /** All forced to be applied to compute a net acceleration upon next move */
  private ArrayList<PVector> forceBacklog = new ArrayList<PVector>();
  
  /** The particles mass */
  private int mass = 1;
  public int getMass(){return this.mass;}
  
  /** All drag constants, combined into 1 */
  private static final float DRAG_CONSTANT = 0.001;
  
  /** Construct with initial location */
  public Particle(PVector location){
    this.location = location;
  }
  
  /** Construct with x and y value */
  public Particle(int x, int y){
    this.location = new PVector(x, y);
  }
  
  /** Construct with location as x and y value, and velocity as horizontal and vertical velocity values */
  public Particle(int x, int y, int x_speed, int y_speed){
    this(x, y);
    this.velocity = new PVector(x_speed, y_speed);
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
      this.forceBacklog = new ArrayList<PVector>();
    }
    this.location.add(this.velocity);
  }
  
  /** Display the particle on screen */
  public void onScreen(){
    noStroke();
    fill(254, 245, 218);
    ellipseMode(RADIUS); // Consider moving to setup()
    ellipse(this.location.x, this.location.y, 10, 10);
  }
  
  /* Apply a drag force to the particle */
  public void drag(){
    float speed = this.velocity.mag();
    PVector direction = this.velocity.get();
    direction.normalize();
    direction.mult(-1);
    direction.normalize();
    direction.mult((Particle.DRAG_CONSTANT * speed * speed));
    this.addForce(direction);
  }
}
