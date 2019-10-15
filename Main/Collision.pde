class Collision {
  PVector position;
  float boxWidth, boxHeight;
  float radius = 25;
  boolean collision = false;

  public Collision(PVector position, float boxWidth, float boxHeight) {
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    objList.add(this);
  }

  void noCollision() {
    float xCollision = player.xObject;
    float yCollision = player.yObject;
    /** if (xCollision + radius < position.x || xCollision - radius > position.x + boxWidth || yCollision + radius < position.y || yCollision - radius > position.y + boxHeight ) {
     collision = false;
     // no collision
     } else { 
     collision = true;
     }*/
    if (xCollision + radius > position.x && xCollision + radius < position.x + boxWidth && yCollision - radius > position.y && yCollision + radius < position.y + boxHeight) {
      collision = true;  
    } else {
      collision = false;
    }
  }
}
