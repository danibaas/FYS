class CharacterSelect {
  boolean hasChosen, choseCorra = true, choseDonDon;
  float defaultSpeed = 5;
  final int CONTROL_TITLE_POSITION_Y = 375, CONTROLS_POSITION_Y1 = 400, CONTROLS_POSITION_Y2 = 425, CONTROLS_POSITION_Y3 = 450, CONTROLS_POSITION_Y4 = 475, CONTROLS_POSITION_Y5 = 550, CONTROLS_POSITION_Y6 = 600;

  void drawSelect() {
    if (!login.loggedIn) {
      login.display();
    } else if (login.loggedIn) {
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
        text("Controls", width/2, CONTROL_TITLE_POSITION_Y);
        text("R/A = Attack", width/2, CONTROLS_POSITION_Y1);
        text("L/S = Special attack", width/2, CONTROLS_POSITION_Y2);
        text("B = Jump", width/2, CONTROLS_POSITION_Y3);
        text("Y = Crouch", width/2, CONTROLS_POSITION_Y4);
        text("Pick this up for a speedboost", width/2, CONTROLS_POSITION_Y5);
        image(coffee, width/2-50, CONTROLS_POSITION_Y6);
        coffee.resize(100, 100);

        // when not selected
        //corra
        textSize(20);
        textAlign(CENTER);
        skinCorra.resize(100, 100);
        image(skinCorra, 450, 100);
        fill(127, 0, 0);
        rect(400, 200, 200, 100);
        fill(0);
        text("Corra", 500, 250);
        text("Normal speed : 8", 500, 325);
        text("Boosted speed : 16", 500, 350);
        //dondon
        skinDonDon.resize(100, 100);
        image(skinDonDon, 730, 100);
        fill(127, 0, 0);
        rect(680, 200, 200, 100);
        fill(0);
        text("Dondon", 780, 250);
        text("Normal speed : 5", 780, 325);
        text("Boosted speed : 10", 780, 350);

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
  }

  void pressed() {
    if (login.loggedIn) {
      if ((key == CODED && keyCode == UP) && !hasChosen) {
        initScreen();
        hasChosen = true;
        soundTrack.loop();
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
    } else if (!login.loggedIn) {
      login.type();
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
    int speedMultiplier = 1; // Speed multiplier wordt bepaald door het level van de speed upgrade
    if (sql.connect()) {
      sql.query("SELECT level FROM Item WHERE name='Speed';");
      if (sql.next()) {
         speedMultiplier = sql.getInt("level"); 
      }
      sql.close();
    }
    if (choseCorra & hasChosen) {
      speed = 8 * speedMultiplier;
    } else if (choseDonDon && hasChosen) {
      speed = 6 * speedMultiplier;
    }
    return speed;
  }
}
