class StrokeParticleVec3 extends ParticleVec3 {
  float numStrokeWeight;
  float alpha;
  float ruptureScale;

  StrokeParticleVec3(PVector l, float ms, float mf, float _r, float _life, float sw) {
    super(l, ms, mf, _r, _life);
    numStrokeWeight = sw;
    alpha = _life * 3;
    ruptureScale = random(1.1, 1.2);
  }

  void update() {
    super.update();
    lifeCheck();
    rupture();
  }
  
  void lifeCheck() {
    if (life <= 0) alpha = 0;
  }
  
  void rupture() {
    if (life <= 0.5) r *= ruptureScale;
  }
  
  void draw() {
    pushMatrix();
    noFill();
    stroke(col, alpha);
    strokeWeight(numStrokeWeight);
    translate(location.x, location.y, location.z);
    ellipse(0, 0, mass * radius * 2 * r, mass * radius * 2 * r);
    popMatrix();
  }
}
