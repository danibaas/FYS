class Login { 
  String playerPassword = "test";
  String playerName = "";
  final int usernameBoxX = 490;
  final int usernameBoxY = height/2;
  int size = 22;
  String returnedusername;
  boolean loggedIn = false;

  void type() { 
    // frameRate(9); 
    if (keyPressed&&key==BACKSPACE) {
      // backspace: remove letter  
      if (playerName.length()>=1) {
        playerName=playerName.substring(0, playerName.length()-1);
      } // if 
      returnedusername=playerName;
    } else if (keyPressed&&key==DELETE) {
      playerName="";
      returnedusername=playerName;
    } else if (keyPressed&&key==' ') {
      playerName+='_';
      returnedusername=playerName;
    } else if (keyPressed&&key==ENTER) {
      if (playerName == "" || playerName == " ") {
        println("no username detected");
      } else {
        if (sql.connect()) 
        {
          sql.execute("INSERT INTO Account VALUES (default, '" + playerName + "', '" + playerPassword + "')");
          loggedIn = true;
          println(playerName);
        }
      }
    } else if (keyPressed&&key!=CODED) { 
      // normal key: add 
      playerName+=key; 
      returnedusername=playerName;
    }
  }

  void display() {
    textSize(size);
    text("Username", usernameBoxX+65, usernameBoxY-40);
    fill(255, 255, 255);
    rect(usernameBoxX-4, usernameBoxY-29, 250, 35);
    fill(0); 
    text(playerName, usernameBoxX, usernameBoxY);
  }
}