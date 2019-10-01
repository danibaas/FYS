class CharacterSelect extends Scene {
  boolean hasChosen = false;

  void Update() {}
  
  void Draw() {
    if (!hasChosen) {
      background(120);
      fill(255, 0, 0);
      strokeWeight(3);
      rect(400, 400, 200, 100);
      rect(680, 400, 200, 100);
    }
  }


  void pressed() {
    if (mousePressed == true && mouseButton == LEFT) {
      if (mouseX>=400 && mouseX<=600 && mouseY>=400 && mouseY<=500) {
        //CharacterSelect Corra
        hasChosen = true;
      } else if (mouseX>=680 && mouseX<=880 && mouseY>=400 && mouseY<=500) {
        //CharacterSelect Dondon
        hasChosen = true;
      }
    }
  }
}
