class Collider {
  PVector position;
  float boxWidth, boxHeight;
  int collisionType;

  Collider(PVector position, float boxWidth, float boxHeight) {
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
  }

  boolean collidesWithPlayer(Player player) { 
    boolean collides = false;
    float playerRadiusW = player.PlayerSizeW / 2;
    float playerRadiusH = player.PlayerSizeH / 2;
    if (player.playerVector.x + playerRadiusW > position.x && player.playerVector.x - playerRadiusW < position.x + boxWidth 
      && player.playerVector.y + playerRadiusH > position.y && player.playerVector.y - playerRadiusH < position.y + boxHeight) {
      collides = true;
      if (player.playerVector.x + playerRadiusW > position.x && player.playerVector.y > position.y && player.playerVector.x < position.x + boxWidth/2) {
        collisionType = CollisionType.LEFT;
      } else if (player.playerVector.x - playerRadiusW < position.x + boxWidth && player.playerVector.y > position.y) {
        collisionType = CollisionType.RIGHT;
      } else if (player.playerVector.y + playerRadiusH > position.y && player.playerVector.x + playerRadiusW > position.x && player.playerVector.x - playerRadiusW < position.x + boxWidth) {
        collisionType = CollisionType.TOP;
      } else {
        collisionType = CollisionType.BOTTOM;
      }
    }
    return collides;
  }

  boolean collidesWithEnemy(Enemy enemy) {
    boolean collides = false;
    if (enemy.position.x + enemy.boxWidth > position.x && enemy.position.x - enemy.boxWidth > position.x + boxWidth) {
      collides = true;
    }
    //boven en onderkant collision van enemy is overbodig?
    return collides;
  }

  boolean collidesWithObstacle(Obstacle obstacle) {
    boolean collides = false;
    if (obstacle.position.x + obstacle.boxWidth > position.x && obstacle.position.x < position.x + boxWidth && obstacle.position.y + obstacle.boxHeight > position.y && obstacle.position.y - obstacle.boxHeight < position.y + boxHeight) {
      collides = true;
    }
    return collides;
  }

  boolean collidesWithObstacle(ArrayList<Obstacle> obstacle) {
    boolean collides = false;
    for (Obstacle obs : obstacle) {
      if (obs.position.x + obs.boxWidth > position.x && obs.position.x < position.x + boxWidth && obs.position.y + obs.boxHeight > position.y && obs.position.y - obs.boxHeight < position.y + boxHeight) {
        collides = true;
      }
    }
    return collides;
  }

  boolean collidesWithPickup(Pickup pickup) {
    boolean collides = false;
    if (pickup.position.x + pickup.boxWidth > position.x && pickup.position.x - pickup.boxWidth > position.x + boxWidth && pickup.position.y + pickup.boxHeight > position.y && pickup.position.y - pickup.boxHeight < position.y + boxHeight) {
      collides = true;
    }
    return collides;
  }

  void moveEntity(boolean collision) {
    if (!collision) {
      if (keys[2] && !player.hasCollision() && !player.stopMoving) {
        position.x -= background.speed;
      } else if (keys[1] && !player.hasCollision() && !player.stopMoving) {
        position.x += background.speed;
      }
    } else {
      if (keys[2] && !player.hasCollision() && !player.stopMoving) {
        position.x += background.speed;
      } else if (keys[1] && !player.hasCollision() && !player.stopMoving) {
        position.x -= background.speed;
      }
    }
  }
}
