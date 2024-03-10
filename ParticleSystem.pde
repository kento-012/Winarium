class ParticleSystem {
  int symbolId;
  FlowField flowfield;
  int NUM = 500;
  ArrayList<ParticleVec3> particles = new ArrayList<ParticleVec3>();
  color particleColor;
  boolean isHit = true;
  float noiseZ;
  float decreaseLife;

  ParticleSystem(int symbolId) {
    this.symbolId = symbolId;
    this.flowfield = new FlowField(20, symbolId);
    this.particleColor = color(360 / 4 * symbolId, 100, 100);

    if (symbolId == 0) {
      noiseZ = 0.05;
      decreaseLife = 0.1;
    }
    if (symbolId == 1) {
      noiseZ = 0.05;
      decreaseLife = 0.1;
    }
    if (symbolId == 2) {
      noiseZ = 0.05;
      decreaseLife = 0.1;
    }
    if (symbolId == 3) {
      noiseZ = 0.05;
      decreaseLife = 0.1;
      //decreaseLife = 0.01;
    }
  }

  void update(boolean isAttraction) {
    if (isAttraction) {
      if (symbolId == 0) {
        attract(flowfield.spot, 200, 5, 20);
      }
      if (symbolId == 1) {
        attract(flowfield.spot, 200, 5, 20);
      }
      if (symbolId == 2) {
        attract(flowfield.spot, 200, 5, 20);
      }
      if (symbolId == 3) {
        attract(flowfield.spot, 200, 5, 20);
      }
    }
    particles.removeIf(particle -> particle.life < 0);
  }

  void updateSpot(PVector pos) {
    flowfield.spot = pos.copy();
    flowfield.state += noiseZ;
    flowfield.init();
  }

  void draw() {
    for (int i = 0; i < particles.size(); i++) {
      ParticleVec3 particle = particles.get(i);

      if (symbolId == 0 || symbolId == 1 || symbolId == 2 ) {    //symbolIdが3の時だけ、flowfieldを適用しない
        particle.follow(flowfield);
      }
      particle.update();
      particle.draw();
      //particle.bounceOffWalls();
      //particles[i].throughWalls();
      particle.life -= decreaseLife;
    }
    if (debug) flowfield.display();
  }

  //0番目
  //サモロドニ　スイートSamorodni Sweet  甘口白
  //新鮮な果物とトロピカルフルーツの香り。酸味と甘味のバランスの取れた甘口ワイン。
  float v0 = 20.0;
  float min_MaxForce = 0.1;

  void gushing0(PVector pos) {
    if (particles.size() < NUM) {
      ParticleVec3 particle = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(80, 120), random(5, 60));
      particle.velocity = new PVector(random(-1, 1), random(-1, 1));
      particle.col = color(345, 100, 100);
      particles.add(particle);

      ParticleVec3 particle2 = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(40, 75), random(5, 50));
      particle2.velocity = new PVector(random(-1, 1), random(-1, 1));
      particle2.col = color(0, 40, 100);
      particles.add(particle2);

      ParticleVec3 particle3 = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(50, 90), random(5, 50));
      particle3.velocity = new PVector(random(-1, 1), random(-1, 1));
      particle3.col = color(40, 100, 100);
      particles.add(particle3);

      ParticleVec3 particle4 = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(40, 100), random(5, 50));
      particle4.velocity = new PVector(random(-1, 1), random(-1, 1));
      particle4.col = color(30, 30, 100);
      particles.add(particle4);

      ParticleVec3 particle5 = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(40, 100), random(0.1, 50));
      particle5.velocity = new PVector(random(-1, 1), random(-1, 1));
      particle5.col = color(0, 100, 50);
      particles.add(particle5);
    }

    //if (particles.size() < 1000) {
    //  //ParticleVec3 particle = new ParticleVec3(pos.add(new PVector(random(-1, 1), random(-1, 1))), random(2, 8), random(min_MaxForce, 0.5), random(2, 4), random(5, 50));
    //  ParticleVec3 particle = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 100), random(2, 10));
    //  particle.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle.col = color(80, 10, 100);
    //  particles.add(particle);

    //  ParticleVec3 particle2 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 100), random(2, 10));
    //  particle2.velocity = new PVector(random(-15, 15), random(-15, 15));
    //  particle2.col = color(80, 30, 100);
    //  particles.add(particle2);

    //  ParticleVec3 particle3 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 100), random(2, 10));
    //  particle3.velocity = new PVector(random(-10, 10), random(-10, 10));
    //  particle3.col = color(80, 70, 100);
    //  particles.add(particle3);
    //}

    //if (particles.size() < NUM) {
    //  ParticleVec3 particle = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(60, 100), random(5, 60), 5);
    //  particle.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle.col = color(260, 80, 10);
    //  particles.add(particle);

    //  ParticleVec3 particle2 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(30, 75), random(5, 40), 5);
    //  particle2.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle2.col = color(280, 100, 10);
    //  particles.add(particle2);

    //  ParticleVec3 particle3 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(50, 90), random(5, 50), 1);
    //  particle3.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle3.col = color(30, 100, 10);
    //  particles.add(particle3);

    //  ParticleVec3 particle4 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(20, 60), random(5, 30), 5);
    //  particle4.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle4.col = color(60, 30, 100);
    //  particles.add(particle4);

    //  ParticleVec3 particle5 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(40, 100), random(0.1, 50), 5);
    //  particle5.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle5.col = color(350, 95, 40);
    //  particles.add(particle5);
    //}
  }

  //1番目
  //キスィーKszi （微発泡　ロゼワイン）  スパークリングロゼ
  //生き生きとしたフルーティーさと繊細な香り。ジューシーな味わいで、いちごの酸味とピンクグレープフルーツの余韻。
  void gushing1(PVector pos) {
    if (particles.size() < NUM) {
      ParticleVec3 particle = new StrokeParticleVec3(pos.copy(), random(100, 200), random(0.01, 0.5), random(20, 80), random(2, 7), random(3.0, 6.0));
      //ParticleVec3 particle = new StrokeParticleVec3(pos.copy(), random(2, 5), random(0.01, 0.5), random(20, 80), random(2, 7), random(3.0, 6.0));
      particle.velocity = new PVector(random(-30, 30), random(-30, 30));
      particle.col = color(350, 20, 100);
      particles.add(particle);

      ParticleVec3 particle2 = new ParticleVec3(pos.copy(), random(2, 5), random(0.1, 0.5), random(40, 100), random(0.1, 30));
      particle2.velocity = new PVector(random(-30, 30), random(-30, 30));
      particle2.col = color(20, 20, 100);
      particles.add(particle2);

      ParticleVec3 particle3 = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(80, 120), random(5, 50));
      particle3.velocity = new PVector(random(-30, 30), random(-30, 30));
      particle3.col = color(350, 100, 100);
      particles.add(particle3);

      ParticleVec3 particle4 = new ParticleVec3(pos.copy(), random(2, 5), random(0.45, 0.5), random(80, 120), random(5, 30));
      particle4.velocity = new PVector(random(-30, 30), random(-30, 30));
      particle4.col = color(350, 30, 100);
      particles.add(particle4);
    }
  }

  //2番目
  //ｴｸﾞﾘ ﾋﾞｶｳﾞｪﾙ ｸﾗｯｼｯｸEgri Bikavér Classicus  辛口赤
  //カシス、プラム、ブラックチェリーなど黒系果実の香りに、少しのバニラ。ミディアムボディーで、後味にマイルドなチョコレート。
  void gushing2(PVector pos) {
    float v0 = 30.0;
    float min_MaxForce = 0.1;

    if (particles.size() < NUM) {
      ParticleVec3 particle = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(60, 100), random(5, 60), 5);
      particle.velocity = new PVector(random(-v0, v0), random(-v0, v0));
      particle.col = color(260, 80, 10);
      particles.add(particle);

      ParticleVec3 particle2 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(30, 75), random(5, 40), 5);
      particle2.velocity = new PVector(random(-v0, v0), random(-v0, v0));
      particle2.col = color(280, 100, 10);
      particles.add(particle2);

      ParticleVec3 particle3 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(50, 90), random(5, 50), 1);
      particle3.velocity = new PVector(random(-v0, v0), random(-v0, v0));
      particle3.col = color(30, 100, 10);
      particles.add(particle3);

      ParticleVec3 particle4 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(20, 60), random(5, 30), 5);
      particle4.velocity = new PVector(random(-v0, v0), random(-v0, v0));
      particle4.col = color(60, 30, 100);
      particles.add(particle4);

      ParticleVec3 particle5 = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(40, 100), random(0.1, 50), 5);
      particle5.velocity = new PVector(random(-v0, v0), random(-v0, v0));
      particle5.col = color(350, 95, 40);
      particles.add(particle5);


      //ParticleVec3 particle = new overlapParticleVec3(pos.copy().add(new PVector(random(-1, 1), random(-1, 1))), random(2, 5), random(min_MaxForce, 0.5), random(60, 100), random(5, 60), 5);
      //ParticleVec3 particle = new overlapParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(60, 100), random(5, 60), 5);
      //particle.velocity = new PVector(random(-v0, v0), random(-v0, v0));
      //particle.col = color(260, 80, 10);
      //particles.add(particle);
    }
  }

  //3番目
  //チーニCsiny  辛口白
  //スイカズラとブドウの花のフローラル ノート、その後シトラスのアロマが続きます。
  //味わいは桃と柑橘類のミックスで、軽快でありながらフレッシュなブドウを思わせる非常に長い余韻があります
  void gushing3(PVector pos) {
    float v0 = 20.0;

    //float angle = random(PI * 2.0);


    //float[] posX = new float[5];
    //float[] posY = new float[5];
    //float[] length = {10, 12, 14, 16, 18} ;

    //for (int i = 0; i < 5; i++) {
    //  float angle = random(PI * 2.0);
    //  posX[i] = cos(angle) * length[i];
    //  posY[i] = sin(angle) * length[i];
    //}

    //float length = random(20);
    //float posX = cos(angle) * length;
    //float posY = sin(angle) * length;

    println(particles.size());

    //if (particles.size() < 1000) {
    //  //ParticleVec3 particle = new ParticleVec3(pos.add(new PVector(random(-1, 1), random(-1, 1))), random(2, 8), random(min_MaxForce, 0.5), random(2, 4), random(5, 50));
    //  ParticleVec3 particle = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 200), random(2, 5));
    //  particle.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle.col = color(80, 10, 100);
    //  particles.add(particle);

    //  ParticleVec3 particle2 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 200), random(2, 5));
    //  particle2.velocity = new PVector(random(-15, 15), random(-15, 15));
    //  particle2.col = color(80, 30, 100);
    //  particles.add(particle2);

    //  ParticleVec3 particle3 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 200), random(2, 5));
    //  particle3.velocity = new PVector(random(-10, 10), random(-10, 10));
    //  particle3.col = color(80, 70, 100);
    //  particles.add(particle3);

    //  ParticleVec3 particle4 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 200), random(2, 5));
    //  particle4.velocity = new PVector(random(-5, 5), random(-5, 5));
    //  particle4.col = color(80, 100, 100);
    //  particles.add(particle4);

    //  ParticleVec3 particle5 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 6), random(5, 50));
    //  particle5.velocity = new PVector(random(-v0, v0), random(-v0, v0));
    //  particle5.col = color(330, 30, 100);
    //  particles.add(particle5);
    //}

    //if (particles.size() < 3000) {
    //  for (int i = 0; i < 5; i++) {
    //    //ParticleVec3 particle = new ParticleVec3(pos.add(new PVector(random(-1, 1), random(-1, 1))), random(2, 8), random(min_MaxForce, 0.5), random(2, 4), random(5, 50));
    //    ParticleVec3 particle = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 40), random(5, 10));
    //    particle.velocity = new PVector(posX, posY);
    //    particle.col = color(80, 90, 100);
    //    particles.add(particle);

    //    ParticleVec3 particle2 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 40), random(5, 10));
    //    particle2.velocity = new PVector(posX, posY);
    //    particle2.col = color(70, 10, 100);
    //    particles.add(particle2);

    //    ParticleVec3 particle3 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 40), random(5, 30));
    //    particle3.velocity = new PVector(posX, posY);
    //    particle3.col = color(60, 100, 100);
    //    particles.add(particle3);

    //    ParticleVec3 particle4 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 40), random(5, 30));
    //    particle4.velocity = new PVector(posX, posY);
    //    particle4.col = color(330, 10, 100);
    //    particles.add(particle4);

    //    ParticleVec3 particle5 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 40), random(5, 30));
    //    particle5.velocity = new PVector(posX, posY);
    //    particle5.col = color(70, 80, 60);
    //    particles.add(particle5);
    //  }
    //}

    if (particles.size() < 3000) {
      for (int i = 0; i < 5; i++) {

//--------------------------------------------
        //float[] posX = new float[5];
        //float[] posY = new float[5];
        //float[] length = new float[5];

        //for (int j = 0; j < 5; j++) {
        //  length[j] = random(20);
        //}

        //for (int j = 0; j < 5; j++) {
        //  float angle = random(PI * 2.0 * random(i));
        //  //posX[j] = cos(angle) * length[i];
        //  //posY[j] = sin(angle) * length[i];
        //  posX[j] = cos(angle) * random(20 * 0.2 * i);
        //  posY[j] = sin(angle) * random(20 * 0.2 * i);
        //}
//------------------------------------------------------------

        //ParticleVec3 particle = new ParticleVec3(pos.add(new PVector(random(-1, 1), random(-1, 1))), random(2, 8), random(min_MaxForce, 0.5), random(2, 4), random(5, 50));
        ParticleVec3 particle = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 4), random(5, 10));
        particle.velocity = new PVector(random(-v0, v0), random(-v0, v0));
        particle.col = color(80, 90, 100);
        particles.add(particle);

        ParticleVec3 particle2 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 4), random(5, 10));
        particle2.velocity = new PVector(random(-v0, v0), random(-v0, v0));
        particle2.col = color(70, 10, 100);
        particles.add(particle2);

        ParticleVec3 particle3 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 4), random(5, 30));
        particle3.velocity = new PVector(random(-v0, v0), random(-v0, v0));
        particle3.col = color(60, 100, 100);
        particles.add(particle3);

        ParticleVec3 particle4 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 4), random(5, 30));
        particle4.velocity = new PVector(random(-v0, v0), random(-v0, v0));
        particle4.col = color(330, 10, 100);
        particles.add(particle4);

        ParticleVec3 particle5 = new ParticleVec3(pos.copy(), random(2, 5), random(min_MaxForce, 0.5), random(2, 4), random(5, 30));
        particle5.velocity = new PVector(random(-v0, v0), random(-v0, v0));
        particle5.col = color(70, 80, 60);
        particles.add(particle5);
      }
    }
  }

  void attract(PVector pos, float mass, float min, float max) {
    for (int j = 0; j < particles.size(); j++) {
      particles.get(j).attract(pos.copy(), mass, min, max);
      //particles.get(i).life++;
    }
  }

  void audioplay() {
    if (isHit) {
      player.rewind();
      player.play();
      isHit = false;
    }
  }
}
