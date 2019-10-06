class Background {
  float Bx = 1280;
  float By = 0;
  float speed = 3;

  float Bx2 = 1920;
  float By2 = 0;

  float Bx3 = 2560;
  float By3 = 0;

  void Displaybg() {
    //BACKGROUND IMAGE
    fill(0, 255, 0);
    //first
    rect(Bx, By, 640, 800);

    fill(255, 0, 0);
    //second
    rect(Bx2, By2, 640, 800);

    fill(10, 10, 225);
    //third
    rect(Bx3, By3, 645, 800);
  }

  void Movebg() {

    //achtergrond blok1
    Bx = Bx - speed;
    if (Bx < -640) {
      Bx = 1280;
    }
    if (Bx > 0 - 1);
    {
    }

    //achtergrond blok2
    Bx2 = Bx2 - speed;
    if (Bx2 < -640) {
      Bx2 = 1280;
    }
    if (Bx2 > 0 - 1);
    {
    }

    //achtergrond blok3
    Bx3 = Bx3 - speed;
    if (Bx3 < -640) {
      Bx3 = 1280;
    }
    if (Bx3 > 0 - 1);
    {
    }
  }
}
