class overlapParticleVec3 extends ParticleVec3 {
  float numOverlap;

  overlapParticleVec3(PVector l, float ms, float mf, float _r, float _life, float _numOverlap) {
    super(l, ms, mf, _r, _life);
    numOverlap = _numOverlap;
  }

  void update() {
    super.update();
  }

  void draw() {
    pushMatrix();
    noStroke();
    translate(location.x, location.y, location.z);
    for (int i = 0; i < numOverlap; i++) {
      fill(hue(col), saturation(col), brightness(col) + i*20, life);
      ellipse(0, 0, mass * radius * 2 * r - i*r*2/numOverlap, mass * radius * 2 * r - i*r*2/numOverlap);
      //ellipse(0, 0, mass * radius * 2 * r - i*r/numOverlap, mass * radius * 2 * r - i*r/numOverlap);
    }
    popMatrix();
  }
}
