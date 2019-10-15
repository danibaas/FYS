class Obstacle extends Collision implements Updater {
  boolean onObstacle, doMove;


  Obstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    updateList.add(this);
  }
  
  void drawObject() {
    rect(position.x, position.y, boxWidth, boxHeight);
  }

  void updateObject() {
    PVector play = new PVector(player.xObject, player.yObject);
    /*if (play.y > position.y &&
     play.x + radius > position.x &&
     play.x < position.x + boxWidth) {
     player.yObject = constrain(player.yObject + player.movement*(int(player.isDown) - int(player.isUp))-boxHeight, radius, height - radius);
     onObstacle = true;
     } else {
     onObstacle=false;
     }*/
    if (keys[2] && doMove) {
      position.x = position.x - background.speed;
    } else if (keys[1] && doMove) {
      position.x = position.x + background.speed;
    }
  }

  void pressedKey() {
        doMove = false;

    if (key == CODED) {
      if (keyCode == RIGHT && !collision) {
        keys[2] = true;
        doMove = true;
      } else if (keyCode == LEFT && !collision) {
        keys[1] = true;
        doMove = true;
      }
    }
  }

  void releasedKey() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        keys[1] = false; 
        doMove = false;
      } else if (keyCode == RIGHT) {
        keys[2] = false;
        doMove = false;
      }
    }
  }
}
