class Enemy extends Block {

  Enemy(PVector position2, float boxWidth2, float boxHeight2) {
    super(position2, boxWidth2, boxHeight2);
  }

  void enemy() {
    if (collision == true) {
      hb.removeHealth();
    }
    rect(position2.x,position2.y,boxWidth2,boxHeight2);
  }
}
