Gravity ball;

void setup(){
  ball = new Gravity();
}

void draw(){
  background(0);
  
  ball.show();
  ball.fall();
  }

void keyPressed(){
  if(key == 'w'){
    ball.jump();
  }
  if(key == 'd'){
    ball.rightmovement();
  }
  if(key == 'a'){
    ball.leftmovement();
  }
}


/*static class Input{
  static int activeKeys;
  
  public static boolean IsKeyPressed(int keyToCheck){
    return (activeKeys & keyToCheck) == keyToCheck;
  }
  
  public static void ToggleOn(int keyToToggle){
   activeKeys |= keyToToggle; 
  }
  
  public static void ToggleOff(int keyToToggle){
   activeKeys &= ~keyToToggle;
  }
}

void keyPressed(){
    switch(key){
      case 'a':
      Input.ToggleOn(Keys.A);
      break;
    }
    
   
}

void keyReleased(){
  switch(key){
    case 'a':
    Input.ToggleOff(Keys.A );
    break;
  }
}

public class Keys{
  final static int A = 1; //0000_0001
  final static int S = 2; //0000_0010
  final static int Z = 4; // etc
  final static int X = 8;
  final static int ArrowUp = 16;
  final static int ArrowDown = 32;
  final static int arrowLeft = 64;
  final static int ArrowRight = 128;
}
/*
