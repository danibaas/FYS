class Background implements Updater {
  float Backgroundx1 = 1280;
  float Backgroundy1 = 0;
  float speed = 10;
  float Backgroundx2 = 1920;
  float Backgroundy2 = 0;
  float Backgroundx3 = 2560;
  float Backgroundy3 = 0;
  float groundHeight = height - 24;
  boolean walkingForward;
  boolean walkingBackward;
  
  
  Background() {
    updateList.add(this);
  }
  void drawObject() {
    //BACKGROUND IMAGE
    
    noStroke();
    //first
    fill(0, 255, 0);
    rect(Backgroundx1, Backgroundy1, 640, 800);

    //second
    fill(255, 0, 0);
    rect(Backgroundx2, Backgroundy2, 640, 800);

    //third
    fill(10, 10, 225);
    rect(Backgroundx3, Backgroundy3, 640, 800);
    stroke(0);
    //ground
    fill(100, 0, 0);
    rect(0-50, groundHeight, width+50, groundHeight);
  }
  
  void updateObject(){
    
  }
  
  void pressedKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        walkingForward = true;
        //achtergrond blok1
        Backgroundx1 = Backgroundx1 - speed;
        Backgroundx2 = Backgroundx2 - speed;
        Backgroundx3 = Backgroundx3 - speed;
      } else if (keyCode == LEFT) {
        walkingBackward=true;
        Backgroundx1 = Backgroundx1 + speed;
        Backgroundx2 = Backgroundx2 + speed;
        Backgroundx3 = Backgroundx3 + speed;
      }
      if (walkingForward) {
        if (Backgroundx1 == 640) {
          Backgroundx2 = 1280;
        }
        if (Backgroundx2 == 640) {
          Backgroundx3 = 1280;
        }
        if (Backgroundx3 == 640) {
          Backgroundx1 = 1280;
        }
      }
      if (walkingBackward) {
        if (Backgroundx1 == 0) {
          Backgroundx3 = -640;
        }
        if (Backgroundx3 == 0) {
          Backgroundx2 = -640;
        }
        if (Backgroundx2 == 0) {
          Backgroundx1 = -640;
        }
      }
    }
    println(Backgroundx1, Backgroundx2, Backgroundx3);
  }

  void releasedKey() {
    walkingForward = false;
    walkingBackward = false;
  }
}
