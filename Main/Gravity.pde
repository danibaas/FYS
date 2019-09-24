class Ball{

float x = 140;
float y = height/4;

float gravity = 0.1;
float felocity = 0;
float upforce = -6;

void jump(){
  felocity += upforce;
  //jump mechanic
}

void leftmovement(){
  x -= 20;
}

void rightmovement(){
  x += 20;
}
  

void fall(){
  felocity += gravity;
  y += felocity;
  //zwaartekracht functie
  
  if(y > height){
    y = height;
    felocity = 0;
    //bal blijft zo binnen het scherm
  }
}

void show(){
  fill(255);
  ellipse(x, y, 50, 50);
}
}
