float achievementCounter = 0;
int A=10;
int startSeconds=0;
float user_id;
void initializeAchievements() {
  if (sql.connect()) {
    sql.execute("SELECT COUNT(name) FROM Achievement");
    if (sql.next()) {
      achievementCounter = sql.getFloat("COUNT(name)");
      println(achievementCounter);
      if (achievementCounter == 0) {
        sql.execute("INSERT INTO Achievement VALUES (1, 'Game Over')");
        sql.execute("INSERT INTO Achievement VALUES (2, 'Corra')");
        sql.execute("INSERT INTO Achievement VALUES (3, 'Dondon')");
        sql.execute("INSERT INTO Achievement VALUES (4, 'Special!')");
        sql.execute("INSERT INTO Achievement VALUES (5, 'Get 100')");
        sql.execute("INSERT INTO Achievement VALUES (6, 'Get 500')");
        sql.execute("INSERT INTO Achievement VALUES (7, 'Get 1000')");
        sql.execute("INSERT INTO Achievement VALUES (8, 'Beat a Boss')");
        sql.execute("INSERT INTO Achievement VALUES (9, 'Shoot an enemy')");
        sql.execute("INSERT INTO Achievement VALUES (10, 'Coffee!!')");
      }
    }
  }
}

void getUserId() {
  if (sql.connect()) {
    sql.execute("SELECT * FROM Account WHERE username='blub'");
    if (sql.next()) {
      user_id = sql.getFloat("user_id");
    }
  }
}

void setAchievement(int achievementNumber) {
  getUserId();
  if (sql.connect()) {
    sql.execute("INSERT INTO Achieved VALUES ('"+user_id+"', ' "+achievementNumber+" ')");
  }
}

boolean achievementDone(int achievementNumber) {
  if (sql.connect()) {
    sql.execute("SELECT * FROM Achieved WHERE user_id='"+user_id+"'");
    if (sql.next()) {
      if (achievementNumber == sql.getFloat("achievementid")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}

void printAchievement(int achievementNumber) {
  if (achievementDone(achievementNumber) == false) {
    setAchievement(achievementNumber);
    if (sql.connect()) {
      sql.execute("SELECT * FROM Achievement WHERE achievementid='" + achievementNumber + "'");
      if (sql.next()) {
        String achievement = sql.getString("name");
        text(achievement, A, A);
        if (startSeconds==0) {
          startSeconds=second();
        }

        if (second() > startSeconds + 10) {
          A = 0;
        }
      }
    }
  }
}
