class Boss extends Collider implements Updater {
  boolean spawnBoss;
  boolean hasBeenHit;
  boolean isDead;
  //int timer;
  //int waitTime = 3000;

  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
    if (spawnBoss && !isDead) {
      rect(position.x+3000, position.y, boxWidth, boxHeight);
    }
    //healthbar.drawBossHealth();
  }

  void updateObject() {
    if (highScore.highScore > 10) {
      spawnBoss = true;
    } 
    moveEntity();
    //healthbar.updateBossHealth();
  }

  void pressedKey() {
  }

  void releasedKey() {
  }
}
