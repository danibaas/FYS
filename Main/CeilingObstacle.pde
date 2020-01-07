class CeilingObstacle extends Obstacle implements Updater {

  CeilingObstacle(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); 
    updateList.add(this);
  }

  void drawObject() {
    image(ceilingObstacle, position.x, position.y);
    println(dist(position.x, position.y+boxHeight, groundObstacle.position.x, groundObstacle.position.y));
    fixLevel();
  }

  void fixLevel() {
  if (dist(position.x, position.y+boxHeight, groundObstacle.position.x, groundObstacle.position.y) < 400){
    position.x += 10;    
  }
}
}
