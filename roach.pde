// 99% of this is from Dan Shiffman's Nature of Code examples!

class Roach {

  PShape cockroach;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float wandertheta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  int roachWidth;
  int roachHeight;
  int alpha;

    Roach(float x, float y, int t_width, int t_height, int t_alpha) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 6;
    wandertheta = 0;
    maxspeed = 2;
    maxforce = 0.05;
    cockroach = loadShape("roach.svg");
    roachWidth = t_width;
    roachHeight = t_height;
    alpha = t_alpha;
  }

  void run() {
    update();
    borders();
    display();
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void wander() {
    float wanderR = 25;         // Radius for our "wander circle"
    float wanderD = 80;         // Distance for our "wander circle"
    float change = 0.7;
    wandertheta += random(-change, change);     // Randomly change wander theta

    // Now we have to calculate the new location to steer towards on the wander circle
    PVector circleloc = velocity.get();    // Start with velocity
    circleloc.normalize();            // Normalize to get heading
    circleloc.mult(wanderD);          // Multiply by distance
    circleloc.add(location);               // Make it relative to boid's location
    if (circleloc.x > width) circleloc.x = width;  //constrain circle to right half of screen
    if (circleloc.x < width/2) circleloc.x = width/2;

      float h = velocity.heading2D();        // We need to know the heading to offset wandertheta

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h), wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circleloc, circleOffSet);
    seek(target);

    // Render wandering circle, etc. 
    drawWanderStuff(location, circleloc, target, wanderR);
  }  

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

      applyForce(steer);
  }

  void display() {
    // Draw a cockroach rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    stroke(0);
    pushMatrix();
    pushStyle();
    translate(location.x, location.y);
    rotate(theta);
    cockroach.disableStyle();
    fill(255,alpha);
    shapeMode(CENTER);
    shape(cockroach, 0, 0, roachWidth, roachHeight);
    popMatrix();
    popStyle();
  }

  // Wraparound
    void borders() {
    if (location.x < width/2) location.x = width/2; // constrain roach to right half of screen
    if (location.y < -r) location.y = height+r;
    if (location.x > width) location.x = width; // same thing
    if (location.y > height+r) location.y = -r;
  }
}


// A method just to draw the circle associated with wandering
void drawWanderStuff(PVector location, PVector circle, PVector target, float rad) {
 pushStyle();
  noStroke();
  noFill();
  ellipseMode(CENTER);
  ellipse(circle.x, circle.y, rad*2, rad*2);
  ellipse(target.x, target.y, 4, 4);
  line(location.x, location.y, circle.x, circle.y);
  line(circle.x, circle.y, target.x, target.y);
  popStyle();
}

