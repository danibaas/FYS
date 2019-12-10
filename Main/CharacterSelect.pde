class CharacterSelect {
  boolean hasChosen, choseCorra = true, choseDonDon;
  float defaultSpeed = 5;

  void drawSelect() {
    if (!hasChosen) {
      background(0, 127, 127);
      textAlign(CENTER);
      strokeWeight(3);

      //titel
      textSize(30);
      fill(0);
      text("Corra & Dondon’s Adventure", width/2, 50);

      //uitleg
      textSize(25);
      textAlign(CENTER);
      text("R = Attack", width/2, 400);
      text("L = Special attack", width/2, 425);
      text("B = Jump", width/2, 450);
      text("Y = Crouch", width/2, 475);
      text("Pick this up for a speedboost", width/2, 550);
      image(coffee, width/2-50, 600);
      coffee.resize(100, 100);

      //not selected
      textSize(20);
      textAlign(CENTER);
      skinCorra.resize(100, 100);
      image(skinCorra, 450, 100);
      fill(127, 0, 0);
      rect(400, 200, 200, 100);
      fill(0);
      text("Corra", 500, 250);
      text("Normal speed : 5", 500, 325);
      text("Boosted speed : 10", 500, 350);

      //when not selected
      skinDonDon.resize(100, 100);
      image(skinDonDon, 730, 100);
      fill(127, 0, 0);
      rect(680, 200, 200, 100);
      fill(0);
      text("Dondon", 780, 250);
      text("Normal speed : 3", 780, 325);
      text("Boosted speed : 5", 780, 350);

      if (choseCorra) {
        fill(255, 0, 0);
        strokeWeight(3);
        rect(400, 200, 200, 100);
        fill(0);
        text("Corra", 500, 250);
      } else if (choseDonDon) {
        fill(255, 0, 0);
        rect(680, 200, 200, 100);
        fill(0);
        text("Dondon", 780, 250);
      }
    }
  }

  void pressed() {
    if ((key == CODED && keyCode == UP) && !hasChosen) {
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
      background.speed = 8;
      player.healthbar = new Healthbar(1);
      player.healthbar.maxLives = 4;
    } else if (choseDonDon && hasChosen) {
      skin = skinDonDon;
      background.speed = 6;
      player.healthbar = new Healthbar(1); 
      player.healthbar.maxLives = 6;
    }
    return skin;
  }

  float getSpeed() {
    float speed = defaultSpeed;
    if (choseCorra & hasChosen) {
      speed = 8;
    } else if (choseDonDon && hasChosen) {
      speed = 6;
    }
    return speed;
  }
}
