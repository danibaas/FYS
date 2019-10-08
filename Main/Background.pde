class Background {
  float Backgroundx = 1280;
  float Backgroundy = 0;
  float speed = 5.5;

  float Backgroundx2 = 1920;
  float Backgroundy2 = 0;

  float Backgroundx3 = 2560;
  float Backgroundy3 = 0;
  
  float groundHeight = height - 24;

  void Displaybg() {
    //BACKGROUND IMAGE

    //first
    fill(0, 255, 0);
    rect(Backgroundx, Backgroundy, 640, 800);

    //second
    fill(255, 0, 0);
    rect(Backgroundx2, Backgroundy2, 640, 800);

    //third
    fill(10, 10, 225);
    rect(Backgroundx3, Backgroundy3, 645, 800);
  }

  void Movebg() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        //achtergrond blok1
        Backgroundx = Backgroundx - speed;
        Backgroundx2 = Backgroundx2 - speed;
        Backgroundx3 = Backgroundx3 - speed;
      } else if (keyCode == LEFT) {
        Backgroundx = Backgroundx + speed;
        Backgroundx2 = Backgroundx2 + speed;
        Backgroundx3 = Backgroundx3 + speed;
      }
      if (Backgroundx < -640) {
        Backgroundx = 1280;
      }
      if (Backgroundx > 0 - 1);
      {
      }

      //achtergrond blok2
      if (Backgroundx2 < -640) {
        Backgroundx2 = 1280;
      }
      if (Backgroundx2 > 0 - 1);
      {
      }

      //achtergrond blok3
      if (Backgroundx3 < -640) {
        Backgroundx3 = 1280;
      }
      if (Backgroundx3 > 0 - 1);
      {
      }
      if (keyCode == UP) {
        if (!jump.ball.airBorne) {
          jump.ball.jump();
          jump.ball.setMove(keyCode, true);
        }
      }
    }
  }
  void Ground(){
  fill(100, 0, 0);
  rect(0-50, groundHeight, width+50, groundHeight);
  }
}
