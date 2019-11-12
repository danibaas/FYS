class Boss extends Collider implements Updater {
  boolean spawnBoss;

  Boss(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }

  void drawObject() {
    println("test");
  }
  void updateObject() {
  }
  void pressedKey() {
  }
  void releasedKey() {
  }
}
