class Block {
  PVector position;
  float boxWidth, boxHeight;
  PVector position2;
  float boxWidth2, boxHeight2;

  public Block(PVector position, float boxWidth, float boxHeight, PVector position2, float boxWidth2, float boxHeight2) {
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    this.position2 = position2;
    this.boxWidth2 = boxWidth2;
    this.boxHeight2 = boxHeight2;
  }

  void noCollision() {
    if (position.x + boxWidth < position2.x || 
      position.x > position2.x + boxWidth2||
      position.y + boxHeight < position2.y || 
      position.y > position2.y + boxHeight2 ) {
      println("noCollision");
      // no collision
      // background speed = 0
    }
    rect(position.x, position.y, boxWidth, boxHeight);
    rect(position2.x, position2.y, boxWidth2, boxHeight2);
  }
}
