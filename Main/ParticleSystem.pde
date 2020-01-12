final int PARTICLE_OFFSET = 50;
final int PARTICLE_LIFE = 40;
class particle {
  float particleX;
  float particleY;
  float particleSpeedX;
  float particleSpeedY;
  float particleSize;
  float particleLife;

 // constructor
  particle(float particleX, float particleY, float particleSpeedX, float particleSpeedY, float particleSize, float particleLife ) {
    this.particleX = particleX;
    this.particleY = particleY;
    this.particleSpeedX = particleSpeedX;
    this.particleSpeedY = particleSpeedY;
    this.particleSize = particleSize;
    this.particleLife = particleLife;
  }


  // draws the particles on the screen
  void drawParticle(int particleRed, int particleYellow, int particleBlue) {
    fill(particleRed, particleYellow, particleBlue);
    noStroke();
    ellipse(particleX, particleY, particleSize, particleSize);
  }
  // makes the particles move
  void move() {
    particleX -= particleSpeedX;
    particleY -= particleSpeedY;
    particleLife --;
  }
}
// puts new particles in the array, moves them, and removes them when their time is up, for running
void addParticleRun() {
  final int PARTICLE_X_MIN = 1;
  final int PARTICLE_X_MAX = 10;
  final int PARTICLE_Y_MIN = 1;
  final int PARTICLE_Y_MAX = 5;
  final int PARTICLE_SIZE_MIN = 5;
  final int PARTICLE_SIZE_MAX = 20;
  if (player.airBorne == false && keys[2] == true) {
    for (int i = 0; i < 1; i++) {
      runParticles.add(new particle(player.position.x, player.position.y+PARTICLE_OFFSET, random(PARTICLE_X_MIN, PARTICLE_X_MAX), random(PARTICLE_Y_MIN, PARTICLE_Y_MAX), random(PARTICLE_SIZE_MIN, PARTICLE_SIZE_MAX), PARTICLE_LIFE));
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
// moves particles in the array, and removes them when their time is up, for shooting
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
