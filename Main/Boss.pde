class Boss extends Collider implements Updater {
  boolean spawnBoss;
  boolean bossGotHurt;

  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    fill(255);
  }

  void updateObject() {
    if (highScore.highScore > 10) {
      spawnBoss = true;
      rect(position.x, position.y, boxWidth, boxHeight);
      println(position.x);
    } else {
      spawnBoss = false;
    }
    moveEntity(false);
  }

  void pressedKey() {
  }
  void releasedKey() {
  }
}
