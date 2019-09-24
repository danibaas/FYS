class StartScene extends Scene {
  Ball ball;

  StartScene() {
    ball = new Ball(new PVector(50, 50), 5);
  }

  void Update() {
    ball.Update();
  }


  void Draw() {
    background(200, 200, 200);
    ball.Draw();
  }
}
