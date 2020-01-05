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



  void drawParticle() {
    fill(0);
    ellipse(particleX, particleY, particleLife, particleLife);
  }

  public void update() {
    for (int i = particles.size()-1; i >= 0; i--) { 
      particle particle = particles.get(i);
      particle.move();
      particle.drawParticle();
      if (particle.particleLife <= 0) {
        particles.remove(i);
      }
    }
  }

  void move() {
    particleX -= particleSpeedX;
    particleY -= particleSpeedY;
  }
}

void addParticle() {

    if (player.position.y >= 600) {
      if(keyPressed && key == CODED && keyCode == RIGHT){
      for (int i = 0; i < 5; i++) {
        particles.add(new particle(player.position.x, player.position.y+50, random(1, 10), random(1, 10), random(1, 10)));
      }
    }}
  
}
