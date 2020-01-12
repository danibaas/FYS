int positionAchievement = 600;
int startSeconds = 0;
int user_id;
boolean done = false;
boolean achievementDone[] = {false, false, false, false, false, false};
boolean achievementInDatabase[] = {false, false, false, false, false, false};
String achievementName[] = {"", "", "", "", "", "", "", "", "", "", ""};
int achievedId = 0;
int achievements;
final int ACHIEVEMENTS = 6;
final int DRAW_TIME = 5;

//Puts the achievements in the database
void initializeAchievements() {
  float achievementCounter = 0;
  if (sql.connect()) {
    sql.execute("SELECT COUNT(name) FROM Achievement");
    if (sql.next()) {
      achievementCounter = sql.getFloat("COUNT(name)");
      if (achievementCounter == 0) {
        sql.execute("INSERT INTO Achievement VALUES (1, 'Get 50')");
        sql.execute("INSERT INTO Achievement VALUES (2, 'Get 100')");
        sql.execute("INSERT INTO Achievement VALUES (3, 'Get 200')");
        sql.execute("INSERT INTO Achievement VALUES (4, 'Get 400')");
        sql.execute("INSERT INTO Achievement VALUES (5, 'Get 800')");
        sql.execute("INSERT INTO Achievement VALUES (6, 'Get 1000')");
      } else if (achievementCounter > ACHIEVEMENTS) {
        sql.execute("DELETE FROM Achieved");
        sql.execute("DELETE FROM Achievement");
        initializeAchievements();
      }
      // gets the names of the achievements so they can be printed on the screen
      for (int i = 1; i < achievementCounter + 1; i++) {
        sql.execute("SELECT * FROM Achievement WHERE achievementid = '"+i+"'");
        if (sql.next()) {
          achievementName[i - 1] = sql.getString("name");
        }
      }
    }
    sql.close();
  }
}

// gets the id of the user from the database, so the achievements will be matched with the right player
void getUserId() {
  if (sql.connect()) {
    sql.execute("SELECT user_id FROM Account WHERE username='" + login.playerName + "'");
    if (sql.next()) {
      user_id = sql.getInt("user_id");
    }
    sql.close();
  }
}

// sets the achievements in the database with the right user id
void setAchievement(int achievementNumber) {
  if (sql.connect()) {
    sql.execute("INSERT INTO Achieved VALUES ('"+user_id+"', ' "+achievementNumber+" ')");
    if (done == true) {
      String sqlQuery = ("UPDATE Achievement SET name = 'Congratulations on completing' WHERE achievementid = 6 AND name LIKE 'G%%' ");
      sql.execute(sqlQuery);
    }
    sql.close();
  }
}

//checks if user already got the achievement before, so it won't be in the database twice
void getAchievements() {
  if (sql.connect()) {
    sql.execute("SELECT achievementid FROM Achieved WHERE user_id = '" + user_id + "' ORDER BY achievementid DESC");
    if (sql.next()) {
      achievements = sql.getInt("achievementid");
    }
  }
  for (int i = 0; i < achievements; i++) {
    achievementInDatabase[i] = true;
  }
}

// the way the achievement is drawn with the timing of how long it is drawn
void drawAchievement(int count) {
  fill(0);
  text(achievementName[count], positionAchievement, positionAchievement);
  if (startSeconds==0) {
    startSeconds=second();
  }
  if (second() > startSeconds + DRAW_TIME) {
    positionAchievement = 0;
  }
}

// draws the achievement on the screen when it is achieved, so the player knows it's achieved
void scoreAchievements() {
  if (highScore.highScore > 50) {
    if (achievementDone[0] == false) {
      achievementDone[0] = true;
    }
    if (positionAchievement != 0 && highScore.highScore < 100) drawAchievement(0);
  }

  if (highScore.highScore > 100) {
    if (achievementDone[1] == false) {
      achievementDone[1] = true;
      startSeconds = 0;
      positionAchievement=600;
    }
    if (positionAchievement != 0 && highScore.highScore < 200) drawAchievement(1);
  }

  if (highScore.highScore > 200) {
    if (achievementDone[2] == false) {
      achievementDone[2] = true;
      startSeconds = 0;
      positionAchievement=600;
    }
    if (positionAchievement != 0 && highScore.highScore < 400) drawAchievement(2);
  }

  if (highScore.highScore > 400) {
    if (achievementDone[3] == false) {
      achievementDone[3] = true;
      startSeconds = 0;
      positionAchievement=600;
    }
    if (positionAchievement != 0 && highScore.highScore < 800) drawAchievement(3);
  }

  if (highScore.highScore > 800) {
    if (achievementDone[4] == false) {
      achievementDone[4] = true;
      startSeconds = 0;
      positionAchievement=600;
    }
    if (positionAchievement != 0 && highScore.highScore < 1000) drawAchievement(4);
  }

  if (highScore.highScore > 1000) {
    if (achievementDone[5] == false) {
      achievementDone[5] = true;
      startSeconds = 0;
      positionAchievement=600;
    }
    if (positionAchievement != 0) drawAchievement(5);
  }
}

// actually puts the achievements in database when achieved
public void endAchievements() {

  if (highScore.highScore > 50 && achievementInDatabase[0] == false) {
    achievementInDatabase[0] = true;
    setAchievement(1);
  }
  if (highScore.highScore > 100 && achievementInDatabase[1] == false) {
    achievementInDatabase[1] = true;
    setAchievement(2);
  }
  if (highScore.highScore > 200 && achievementInDatabase[2] == false) {
    achievementInDatabase[2] = true;
    setAchievement(3);
  }
  if (highScore.highScore > 400 && achievementInDatabase[3] == false) {
    achievementInDatabase[3] = true;
    setAchievement(4);
  }
  if (highScore.highScore > 800 && achievementInDatabase[4] == false) {
    achievementInDatabase[4] = true;
    setAchievement(5);
  }
  if (highScore.highScore > 1000 && achievementInDatabase[5] == false) {
    achievementInDatabase[5] = true;
    setAchievement(6);
    done = true;
  }
}
