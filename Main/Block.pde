class Block {

  PVector position2;
  float boxWidth2, boxHeight2;
  float radius = 25;
  boolean collision = false;


  public Block(PVector position2, float boxWidth2, float boxHeight2) {
    this.position2 = position2;
    this.boxWidth2 = boxWidth2;
    this.boxHeight2 = boxHeight2;
  }

  void noCollision() {
    float x = jump.ball.x;
    float y = jump.ball.y;
    if (x + radius < position2.x || 
      x - radius > position2.x + boxWidth2||
      y + radius < position2.y || 
      y - radius > position2.y + boxHeight2 ) {
      collision = false;
      // no collision
    } else { 
      collision = true;
    }
    rect(position2.x, position2.y, boxWidth2, boxHeight2);
  }
}
