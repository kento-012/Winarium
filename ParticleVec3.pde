class ParticleVec3 {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector gravity;
  float mass;
  float friction;
  PVector min;
  PVector max;
  float radius;
  float G;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float life;
  float r;
  color col;
  float changeCol;


  ParticleVec3(PVector l, float ms, float mf, float _r, float _life) {
    location = l;
    radius = 1.0;
    mass = 1.0;
    friction = 0.01;
    G = 1.0;
    velocity = new PVector(0.0, 0.0, 0.0);
    acceleration = new PVector(0.0, 0.0, 0.0);
    gravity = new PVector(0.0, 0.0, 0.0);
    min = new PVector(0.0, 0.0, 0.0);
    max = new PVector(width, height, height/2);
    maxspeed = ms;
    maxforce = mf;
    r = _r;
    life = _life;
  }

  void follow(FlowField flow) {
    // What is the vector at that spot in the flow field?
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force　
    applyForce(steer);
  }


  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void update() {
    acceleration.add(gravity);
    velocity.add(acceleration);
    velocity.mult(1.0 - friction);
    location.add(velocity);
    acceleration.set(0, 0, 0);
  }

  void draw() {
    noStroke();
    pushMatrix();
    translate(location.x, location.y, location.z);
    fill(col, life);
    ellipse(0, 0, mass * radius * 2 * r, mass * radius * 2 * r);
    popMatrix();
  }

  void addForce(PVector force) {
    force.div(mass);
    acceleration.add(force);
  }

  void attract(PVector center, float _mass, float min, float max) {
    float distance = PVector.dist(center, location);
    distance = constrain(distance, min, max);
    float strength = G * (mass * _mass) / (distance * distance);
    PVector force = PVector.sub(center, location);
    force.normalize();
    force.mult(strength);
    addForce(force);
  }


  void bounceOffWalls() {
    if (location.x > max.x) {
      location.x = max.x;
      velocity.x *= -1;
    }
    if (location.x < min.x) {
      location.x = min.x;
      velocity.x *= -1;
    }
    if (location.y > max.y) {
      location.y = max.y;
      velocity.y *= -1;
    }
    if (location.y < min.y) {
      location.y = min.y;
      velocity.y *= -1;
    }
    if (location.z > max.z) {
      location.z = max.z;
      velocity.z *= -1;
    }
    if (location.z < min.z) {
      location.z = min.z;
      velocity.z *= -1;
    }
  }

  void throughWalls() {
    if (location.x > max.x) {
      location.x = min.x;
    }
    if (location.x < min.x) {
      location.x = max.x;
    }
    if (location.y > max.y) {
      location.y = min.y;
    }
    if (location.y < min.y) {
      location.y = max.y;
    }
    if (location.z > max.z) {
      location.z = min.z;
    }
    if (location.z < min.z) {
      location.z = max.z;
    }
  }
}
