class particle {
  float particleX;
  float particleY;
  float particleSpeedX;
  float particleSpeedY;
  float particleSize;
  float particleLife;

  particle(float particleX, float particleY, float particleSpeedX, float particleSpeedY, float particleLife ) {
    this.particleX = particleX;
    this.particleY = particleY;
    this.particleSpeedX = particleSpeedX;
    this.particleSpeedY = particleSpeedY;
    this.particleLife = particleLife;
  }



  void drawParticle(int particleRed, int particleYellow, int particleBlue) {
    fill(particleRed, particleYellow, particleBlue);
    noStroke();
    ellipse(particleX, particleY, particleLife, particleLife);
  }

  void move() {
    particleX -= particleSpeedX;
    particleY -= particleSpeedY;
  }
}

void addParticleRun() {

  if (player.airBorne == false && keys[2] == true) {
    for (int i = 0; i < 1; i++) {
      runParticles.add(new particle(player.position.x, player.position.y+50, random(1, 10), random(1, 5), random(5, 20)));
    }
  }
  for (int i = runParticles.size()-1; i >= 0; i--) { 
    particle particle = runParticles.get(i);
    particle.move();
    particle.drawParticle(150, 150, 150);
    if (particle.particleLife <= 0) {
      runParticles.remove(i);
    }
  }
}

void addParticleShoot() {
  for (int i = shootParticles.size()-1; i >= 0; i--) { 
    particle particle = shootParticles.get(i);
    particle.move();
    particle.drawParticle(255, 0, 0);
    if (particle.particleLife <= 0) {
      shootParticles.remove(i);
    }
  }
}
