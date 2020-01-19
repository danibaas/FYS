class Login { 
  String playerPassword = "test";
  String playerName = "";
  final int usernameBoxX = 520;
  final int usernameBoxY = height/2;
  int size = 22;
  String returnedusername;
  boolean loggedIn = false;

  //source: https://forum.processing.org/two/discussion/5697/taking-away-the-last-added-character-from-a-string
  //login text box met zelf toegevoegde functies
  void type() { 
    //haal laatste letter weg van de string
    if (playerName.length() >= 17) {
      if (keyPressed&&key==BACKSPACE) {
        // backspace: remove letter  
        if (playerName.length()>=1) {
          playerName=playerName.substring(0, playerName.length()-1);
        }
        returnedusername=playerName;
      }
    } else if (keyPressed&&key==BACKSPACE) {
      // backspace: remove letter  
      if (playerName.length()>=1) {
        playerName=playerName.substring(0, playerName.length()-1);
      }
      returnedusername=playerName;
    //als je delete klikt dan wis je de hele playername
    } else if (keyPressed&&key==DELETE) {
      playerName="";
      returnedusername=playerName;
    //als je spatie drukt dan word de spatie vervangen met een underscore
    } else if (keyPressed&&key==' ') {
      playerName+='_';
      returnedusername=playerName;
    //als je op enter drukt dan word de playername gestuurt naar de database als die er nog niet instaat
    } else if (keyPressed&&key==ENTER) {
      if (playerName == "" || playerName == " ") {
        println("no username detected");
      } else {
        if (sql.connect()) {
          sql.query("SELECT * FROM Account WHERE username='" + playerName + "';");
          if (!sql.next()) {
            sql.execute("INSERT INTO Account VALUES (default, '" + playerName + "', 0)");
            shop.insertItems();
          }
          loggedIn = true;
          getUserId();
          getAchievements();
          sql.close();
        }
      }
    //voeg letter toe aan de playername string
    } else if (keyPressed&&key!=CODED) { 
      playerName+=key; 
      returnedusername=playerName;
      //getUserId();
    }
  }
  //laat textbox zien
  void display() {
    textAlign(LEFT);
    background(127);
    textSize(size);
    text("Username", usernameBoxX+65, usernameBoxY-40);
    fill(255, 255, 255);
    rect(usernameBoxX-4, usernameBoxY-29, 250, 35);
    fill(0); 
    text(playerName, usernameBoxX, usernameBoxY);
  }
}
