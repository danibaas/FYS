class Collider {
  PVector position;
  float boxWidth, boxHeight;

  Collider(PVector position, float boxWidth, float boxHeight) {
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    collisionList.add(this);
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
    }
    return collides;
  }

  void moveEntity() {
    position.x -= background.speed;
  }
}
