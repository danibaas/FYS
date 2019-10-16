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
    float playerRadius = player.playerSize / 2;
    if (player.playerVector.x + playerRadius > position.x && player.playerVector.x - playerRadius < position.x + boxWidth 
      && player.playerVector.y + playerRadius > position.y && player.playerVector.y - playerRadius < position.y + boxHeight) {
      collides = true;
      //println(player.playerVector.x + playerRadius > position.x, player.playerVector.y > position.y, player.playerVector.x < position.x + boxWidth/2);
      if (player.playerVector.x + playerRadius > position.x && player.playerVector.y > position.y && player.playerVector.x < position.x + boxWidth/2) {
        collisionType = CollisionType.LEFT;
      } else if (player.playerVector.x - playerRadius < position.x + boxWidth && player.playerVector.y > position.y) {
        collisionType = CollisionType.RIGHT;
      } else if (player.playerVector.y + playerRadius > position.y && player.playerVector.x + playerRadius > position.x && player.playerVector.x - playerRadius < position.x + boxWidth) {
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
