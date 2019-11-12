class Boss extends Collider implements Updater {
  boolean spawnBoss;

  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
    moveEntity(false);
    println(spawnBoss);
  }
  void updateObject() {
    if (highScore.highScore > 100) {
      spawnBoss = true;
    } else {
      spawnBoss = false;
    }
  }
  void pressedKey() {
  }
  void releasedKey() {
  }
}
