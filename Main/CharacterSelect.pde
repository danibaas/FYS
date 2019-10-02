/*class CharacterSelect {
  boolean hasChosen = false;

  void drawSelect() {
    if (!hasChosen) {
      background(120);
      fill(255, 0, 0);
      strokeWeight(3);
      rect(400, 400, 200, 100);
      fill(0);
      textAlign(CENTER);
      text("CORRA", 500, 450);
      fill(255, 0, 0);
      rect(680, 400, 200, 100);
      fill(0);
      textAlign(CENTER);
      text("DONDON", 780, 450);
    }
  }


  void pressed() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        //CharacterSelect Corra
        hasChosen = true;
      } else if (keyCode == RIGHT) {
        //CharacterSelect Dondon
        hasChosen = true;
      }
    }
    /*if (mousePressed && mouseButton == LEFT) {
      if (mouseX>=400 && mouseX<=600 && mouseY>=400 && mouseY<=500) {
        //CharacterSelect Corra
        hasChosen = true;
      } else if (mouseX>=680 && mouseX<=880 && mouseY>=400 && mouseY<=500) {
        //CharacterSelect Dondon
        hasChosen = true;
      }
    }
  }
}*/
