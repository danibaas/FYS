class Obstacle extends Collider {
  int timer;
  int beginPosition = 1300;
  final int WAIT_TIME = 2000;
  final int RESPAWN_MIN = 1300;
  final int RESPAWN_MAX = 1700;

  // Constructor 
  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); // Geef de data door aan de constructor van de parent class (collider)
    obstacleList.add(this);
  }

  // Update methode
  void updateObject() {
    if (collidesWithPlayer(player)) {
      player.healthbar.isDead = true;
    } else {
      for (Coin coins : money.allCoins) { // Voor elke coin in de arraylist allCoins, doe...
        if (collides(coins)) {
          if (coins.position.x + coins.boxWidth > position.x + boxWidth) {
            //position.x -= 10;
          } else {
            //position.x += 10;
          }
        }
      }
      if (!boss.spawnBoss) {
        loopObstacle();
        if (canWalk()) {
          moveEntity();
        }
      } else {
        if (position.x + boxWidth > 0 && position.x + boxWidth < width && keys[2]) { // Als de boss actief is en het obstakel in beeld, beweeg hem uit het beeld
          moveEntity();
        }
      }
    }
  }

  // Method om het obstakel te laten loopen
  void loopObstacle() {
    if (position.x + boxWidth < 0 && canWalk()) {
      timer = millis(); 
      position.x = (int) random(RESPAWN_MIN, RESPAWN_MAX);
    }
  }

  // Future parent method (ivm inheritance in ground- en ceilingobstacle
  void pressedKey() {
  }

  // Future parent method (ivm inheritance in ground- en ceilingobstacle 
  void releasedKey() {
  }

  // Methode die kijkt of het obstakel mag bewegen (dus cooldown & player moet lopen)
  boolean canWalk() {
    boolean walk = false;
    if (timer + WAIT_TIME < millis() && keys[2]) {
      walk = true;
    }
    return walk;
  }
}
