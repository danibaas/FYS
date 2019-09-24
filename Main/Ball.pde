class Ball {
  PVector position;
  float radius;

  Ball(PVector position, float radius) {
    this.position = position; 
    this.radius = radius;
  }

  void Update() {
    position =  position.add(new PVector(10, 0));
  }

  void Draw() {
    ellipse(position.x, position.y, radius, radius) ;
  }
}
