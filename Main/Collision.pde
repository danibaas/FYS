/*class Collision {
 PVector position;
 float boxWidth, boxHeight;
 float radius = 25;
 boolean collision = false;
 
 public Collision(PVector position, float boxWidth, float boxHeight) {
 this.position = position;
 this.boxWidth = boxWidth;
 this.boxHeight = boxHeight;
 objList.add(this);
 }
 
 void noCollision() {
 float xCollision = player.xObject;
 float yCollision = player.yObject;
/** if (xCollision + radius < position.x || xCollision - radius > position.x + boxWidth || yCollision + radius < position.y || yCollision - radius > position.y + boxHeight ) {
 collision = false;
 // no collision
 } else { 
 collision = true;
 }
 if (xCollision + radius > position.x && xCollision + radius < position.x + boxWidth && yCollision - radius > position.y && yCollision + radius < position.y + boxHeight) {
 collision = true;  
 
 } else {
 collision = false;
 }
 }
 }*/

interface CollisionType {
  int
    LEFT = 0, 
    BOTTOM = 1, 
    RIGHT = 2, 
    TOP = 3;
}

class Collider {
  PVector position;
  float boxWidth, boxHeight, radius;
  int collisionType;

  Collider(PVector position, float boxWidth, float boxHeight) {
    this.position = position;
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;
    radius = boxWidth / 2;
  }

  boolean collidesWithPlayer(Player player) { 
    boolean collides = false;
    float playerRadius = player.playerSize / 2;
    if (player.playerVector.x + playerRadius > position.x && player.playerVector.x - playerRadius < position.x + boxWidth && player.playerVector.y + playerRadius > position.y && player.playerVector.y - playerRadius < position.y + boxHeight) {
      collides = true;
      if (player.playerVector.x + playerRadius > position.x) {
       collisionType = CollisionType.RIGHT; 
      } else if (player.playerVector.x - playerRadius < position.x + boxWidth) {
         collisionType = CollisionType.LEFT; 
      } else if (player.playerVector.y + playerRadius > position.y) {
         collisionType = CollisionType.BOTTOM; 
      } else {
        collisionType = CollisionType.UP;
      }
    }
    return collides;
  }

  boolean collidesWithEnemy(Enemy enemy) {
    boolean collides = false;
    if (enemy.position.x + enemy.boxWidth > position.x && enemy.position.x - enemy.boxWidth > position.x + boxWidth) {
      collides = true;
    }
    //boven en onderkant collision van enemy is overbodig?
    return collides;
  }

  boolean collidesWithObstacle(Obstacle obstacle) {
    boolean collides = false;
    if (obstacle.position.x + obstacle.boxWidth > position.x && obstacle.position.x < position.x + boxWidth && obstacle.position.y + obstacle.boxHeight > position.y && obstacle.position.y - obstacle.boxHeight < position.y + boxHeight) {
      collides = true;
    }
    return collides;
  }

  boolean collidesWithPickup(Pickup pickup) {
    boolean collides = false;
    if (pickup.position.x + pickup.boxWidth > position.x) { // rechterkant van pickup, linkerkant van collider
      collides = true;
    }
    if (pickup.position.x - pickup.boxWidth > position.x + boxWidth) { // links van pickup, rechts van collider
      collides = true;
    }
    if (pickup.position.y + pickup.boxHeight > position.y) { // onderkant van pickup, bovenkant van collider
      collides = true;
    }
    if (pickup.position.y - pickup.boxHeight < position.y + boxHeight) { // bovenkant pickup, onderkant collider
      collides = true;
    }
    return collides;
  }
}
