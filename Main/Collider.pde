class Collider {
  PVector position;
  float boxWidth, boxHeight;

  Collider(PVector position, float boxWidth, float boxHeight) {
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    collisionList.add(this);
  }

  void update() {
    if (!player.hasCollision()) {
      player.collisionType = CollisionType.NONE;
      player.collisionType = CollisionType.NONE;
      player.colliderType = ColliderType.NONE;
    }
  }

  boolean collides(Collider instance) {
    boolean collides = false;
    float xPos = instance.position.x;
    float yPos = instance.position.y;
    float colliderWidth = instance.boxWidth;
    float colliderHeight = instance.boxHeight;
    if (xPos + colliderWidth > position.x && xPos < position.x + boxWidth && yPos + colliderHeight > position.y && yPos < position.y + boxHeight) {
      collides = true;
    }
    return collides;
  }

  boolean collidesWithPlayer(Player player) { 
    boolean collides = false;
    float playerRadiusW = player.playerWidth / 2;
    float playerRadiusH = player.playerHeight / 2;
    if (player.playerVector.x + playerRadiusW >= position.x && player.playerVector.x - playerRadiusW <= position.x + boxWidth 
      && player.playerVector.y + playerRadiusH >= position.y && player.playerVector.y - playerRadiusH <= position.y + boxHeight) {
      collides = true;
      if (player.playerVector.y + playerRadiusH >= position.y && player.playerVector.x + playerRadiusW >= position.x && player.playerVector.x - playerRadiusW <= position.x + boxWidth) {
        player.collisionType = CollisionType.TOP;
      } else if (player.playerVector.x + playerRadiusW >= position.x && player.playerVector.y >= position.y && player.playerVector.x <= position.x + boxWidth/2) {
        player.collisionType = CollisionType.LEFT;
      } else if (player.playerVector.x - playerRadiusW <= position.x + boxWidth && player.playerVector.y >= position.y) {
        player.collisionType = CollisionType.RIGHT;
      } else {
        player.collisionType = CollisionType.BOTTOM;
      }
    }
    return collides;
  }

  void moveEntity(boolean collision) {
    if (!(player.colliderType == ColliderType.OBSTACLE)) {
      if (!collision || player.collisionType == CollisionType.TOP) {
        if (keys[2] && !player.stopMoving) {
          position.x -= background.speed;
        }
      } else {
        if (keys[2] && !player.stopMoving) {
          position.x += background.speed;
        }
      }
    } else {
      if (player.collisionType == CollisionType.TOP) {
        if (keys[2] && !player.stopMoving) {
          position.x -= background.speed;
        }
      }
    }
  }
}
