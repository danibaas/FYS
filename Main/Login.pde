class Login { 
  String playerPassword = "test";
  String playerName = "";
  final int usernameBoxX = 520;
  final int usernameBoxY = height/2;
  int size = 22;
  String returnedusername;
  boolean loggedIn = false;

  void type() { 
    if (playerName.length() >= 17) {
      if (keyPressed&&key==BACKSPACE) {
        // backspace: remove letter  
        if (playerName.length()>=1) {
          playerName=playerName.substring(0, playerName.length()-1);
        } // if 
        returnedusername=playerName;
      }
    } else if (keyPressed&&key==BACKSPACE) {
      // backspace: remove letter  
      if (playerName.length()>=1) {
        playerName=playerName.substring(0, playerName.length()-1);
      }
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
        if (sql.connect()) {
          sql.query("SELECT * FROM Account WHERE username='" + playerName + "';");
          if (sql.next()) {
            String password = sql.getString("password");
            if (password.equals(playerPassword)) {
              loggedIn = true;
            } else {
              println("Incorrect Password!");
            }
          } else {
            sql.execute("INSERT INTO Account VALUES (default, '" + playerName + "', '" + playerPassword + "')");
            loggedIn = true;
          }
          println(playerName);
          sql.close();
        }
      }
    } else if (keyPressed&&key!=CODED) { 
      playerName+=key; 
      returnedusername=playerName;
    }
  }

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
