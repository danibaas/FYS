/*class CharacterSelect {
 boolean hasChosen, choseCorra, choseDonDon;
 
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
 choseCorra = true;
 hasChosen = true;
 } else if (keyCode == RIGHT) {
 //CharacterSelect Dondon
 choseDonDon = true;
 hasChosen = true;
 }
 }
 }
 
 PImage getPlayerSkin() {
 PImage skin = loadImage("player.png");
 if (choseCorra) {
 // corra skin
 } else if (choseDonDon) {
 // dondon skin
 }
 return skin;
 }
 }*/
