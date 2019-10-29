class CharacterSelect {
  boolean hasChosen, choseCorra, choseDonDon;

  void drawSelect() {
    PImage skinDonDon = loadImage(sketchPath() + "/lib/dondon.png");
    PImage skinCorra = loadImage(sketchPath() + "/lib/corra.png");
    if (!hasChosen) {
      background(120);
      textAlign(CENTER);
      strokeWeight(3);

      //not selected
      skinCorra.resize(100, 100);
      image(skinCorra, 400+50, 250);
      fill(127, 0, 0);
      rect(400, 400, 200, 100);
      fill(0);
      text("CORRA", 500, 450);

      //when not selected
      skinDonDon.resize(100, 100);
      image(skinDonDon, 680+50, 250);
      fill(127, 0, 0);
      rect(680, 400, 200, 100);
      fill(0);
      text("DONDON", 780, 450);

      if (choseCorra) {
        fill(255, 0, 0);
        strokeWeight(3);
        rect(400, 400, 200, 100);
        fill(0);
        text("CORRA", 500, 450);
      } else if (choseDonDon) {
        fill(255, 0, 0);
        rect(680, 400, 200, 100);
        fill(0);
        text("DONDON", 780, 450);
      }
    }
  }

  void pressed() {
    if (key == 'a' && !hasChosen) {
      hasChosen = true;
    }
    if (key == CODED) {
      if (keyCode == LEFT) {
        //CharacterSelect Corra
        choseCorra = true;
        choseDonDon = false;
      } else if (keyCode == RIGHT) {
        //CharacterSelect Dondon
        choseDonDon = true;
        choseCorra = false;
      }
    }
  }


  PImage getPlayerSkin() {
    PImage skin = loadImage(sketchPath() + "/lib/player.png");
    if (choseCorra && hasChosen) {
      // corra skin
      skin = loadImage(sketchPath() + "/lib/corra.png");
    } else if (choseDonDon && hasChosen) {
      // dondon skin
      skin = loadImage(sketchPath() + "/lib/dondon.png");
    }
    return skin;
  }
}
