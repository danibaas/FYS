class Shop {
  PVector icon = new PVector(1100, 10);
  boolean selected, showShop;

  void drawShop() { // Draw the actual shop with upgrades in it
    if (showShop) {
      fill(200);
      rect(200, 100, 800, 500);
      stroke(5);
      fill(210);
      rect(210, 110, 780, 100);
      image(speed_upgrade, 210, 110);
    }
  }

  void drawIcon() { // Draw Icon that opens the shop
    if (selected) {
      image(shopIcon, icon.x, icon.y);
    } else {
      tint(200, 200);
      image(shopIcon, icon.x, icon.y);
      noTint();
    }
  }

  void pressedKey() {
    if (key == 'c' || key == 'C') {
      showShop = true;
    } else if (key == 'v') {
      showShop = false;
    } // if the red button on our controller is pressed set the shop to false
  }
}  
