class CharacterSelect {
  boolean hasChosen, choseCorra = true, choseDonDon;
  float defaultSpeed = 5;

  void drawSelect() {
    if (!hasChosen) {
      background(0, 127, 0);
      textAlign(CENTER);
      strokeWeight(3);

      //show last highscore
      textSize(50);
      fill(0);
      text("Corra & Dondon’s saving Corendon", width/2, 100);
      //text("Saving Corendon", width/2, 150);
      textAlign(RIGHT, CENTER);
      text("Highscore : ", 1280, 200);
      text("123456789", 1280, 250);

      //sound options
      image(soundOn, 0, 0, 50, 50);
      //rect(0, 0, 50, 50);

      //not selected
      textSize(20);
      textAlign(CENTER);
      skinCorra.resize(100, 100);
      image(skinCorra, 400+50, 250);
      fill(127, 0, 0);
      rect(400, 400, 200, 100);
      fill(0);
      text("CORRA", 500, 450);
      text("Normal speed : 5", 500, 525);
      text("Coffee speed : 10", 500, 550);

      //when not selected
      skinDonDon.resize(100, 100);
      image(skinDonDon, 680+50, 250);
      fill(127, 0, 0);
      rect(680, 400, 200, 100);
      fill(0);
      text("DONDON", 780, 450);
      text("Normal speed : 3", 780, 525);
      text("Boosted speed : 5", 780, 550);

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
    if (key == ENTER && !hasChosen) {
      initScreen();
      hasChosen = true;
      player.updateSkin();
    }
    if (key == CODED) {
      if (keyCode == LEFT) {
        choseCorra = true;
        choseDonDon = false;
      } else if (keyCode == RIGHT) {
        choseDonDon = true;
        choseCorra = false;
      }
    }
  }

  PImage getPlayerSkin() {
    PImage skin = defaultSkin;
    if (choseCorra && hasChosen) {
      skin = skinCorra;
      background.speed = 5;
      player.healthbar = new Healthbar(1);
      player.healthbar.maxLives = 4;
    } else if (choseDonDon && hasChosen) {
      skin = skinDonDon;
      background.speed = 3;
      player.healthbar = new Healthbar(1); 
      player.healthbar.maxLives = 6;
    }
    return skin;
  }

  float getSpeed() {
    float speed = defaultSpeed;
    if (choseCorra & hasChosen) {
      speed = 5;
    } else if (choseDonDon && hasChosen) {
      speed = 3;
    }
    return speed;
  }
}
