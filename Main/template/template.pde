//main

Scene activeScene;

//scenes

//setup
void setup(){
 //16:9
 size(1600,900);
 activeScene = new StartScene();
 
}

// the game loop
void draw(){
  activeScene.Update();
  activeScene.Draw();
}

abstract class Scene{
  abstract void Update();
  abstract void Draw();
}

class StartScene extends Scene{
  Ball ball;
  
  StartScene(){
   ball = new Ball(new PVector(50,50),5); 
  }
  
  void Update(){
    ball.Update();
  }
  
  
  void Draw(){
    background(200,200,200);
    ball.Draw();
  }
}

class Ball{
 PVector position;
 float radius;
 
 Ball(PVector position, float radius){
  this.position = position; 
  this.radius = radius;
 }
 
 void Update(){
  position =  position.add(new PVector(10,0)); 
 }
 
 void Draw(){
  ellipse(position.x,position.y,radius,radius) ;
 }
}
