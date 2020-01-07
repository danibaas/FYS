class Shop {
  PVector icon = new PVector(1100, 10);
  boolean showShop;

  void insertItems() {
    if (sql.connect()) {
      sql.query("SELECT * FROM Item;");
      if (!sql.next()) {
        sql.execute("INSERT INTO Item (name, value, level) VALUES ('NormalSpeed', '500', '1');");
        int userid = 0;
        int itemid = 0;
        sql.query("SELECT user_id FROM Account WHERE username='" + login.playerName + "';");
        if (sql.next()) {
          userid = sql.getInt("user_id");
        }
        sql.query("SELECT itemid FROM Item WHERE name=CONCAT('Normal', 'Speed');");
        if (sql.next()) {
          itemid = sql.getInt("itemid");
        }
        sql.execute("INSERT INTO Shop VALUES (" + userid + ", " + itemid + ");");
      } else {
        sql.query("SELECT * FROM ((Shop INNER JOIN Account ON Shop.user_id = Account.user_id) INNER JOIN Item ON Shop.itemid = Item.itemid) WHERE username='" + login.playerName + "';");   
        if (!sql.next()) {
          int userid = 0;
          int itemid = 0;
          sql.query("SELECT * FROM Account WHERE username='" + login.playerName + "';");
          if (sql.next()) {
            userid = sql.getInt("user_id");
          }
          sql.query("SELECT * FROM Item WHERE name='NormalSpeed';");
          if (sql.next()) {
            itemid = sql.getInt("itemid");
          }
          sql.execute("INSERT INTO Shop VALUES (" + userid + ", " + itemid + ");");
        }
      }
      sql.close();
    }
  }

  int getUserAmount(int itemid) { // get the amount of users that have the item
    int amount = 0;
    if (sql.connect()) {
      sql.query("SELECT COUNT(user_id) FROM Shop WHERE itemid='" + itemid + "' GROUP BY itemid;");
      if (sql.next()) {
        amount = sql.getInt("COUNT(user_id)");
      }
      sql.close();
    }
    return amount;
  }

  void drawShop() { // Draw the actual shop with upgrades in it
    if (showShop) {
      fill(200);
      rect(200, 100, 800, 500);
      stroke(5);
      fill(210);
      rect(210, 110, 780, 100);
      image(speed_upgrade, 210, 110);
      if (canUpgrade()) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      text("Speed Upgrade", 650, 150);
      text("500", 650, 180);
      textSize(18);
      text("Achieved " + getUserAmount(1) + " time(s)!", 900, 160);
    }
  }

  void drawIcon() { // Draw Icon that opens the shop
    tint(200, 200);
    image(shopIcon, icon.x, icon.y);
    noTint();
  }

  void pressedKey() {
    if (key == 'c' || key == 'C') {
      showShop = true;
    } else if (key == 'b') {
      showShop = false;
    } else if (key == ENTER) {
      if (showShop) {
        if (canUpgrade()) {
          int userid = metrics.getUserId(login.playerName);
          if (sql.connect()) {
            // remove coins from table money
            int itemValue = 0;
            sql.query("SELECT * FROM Item WHERE name='Speed';");
            if (sql.next()) {
              itemValue = sql.getInt("value");
            }
            sql.query("SELECT * FROM Money WHERE user_id='" + userid + "';");
            int coins = 0;
            if (sql.next()) {
              coins = sql.getInt("coins");
            }
            int totalCoins = coins - itemValue;
            int itemid = 0;
            sql.query("SELECT * FROM Item WHERE name='Speed';");
            if (sql.next()) {
              itemid = sql.getInt("itemid");
            }
            sql.execute("UPDATE Money SET coins='" + totalCoins + "';");
            sql.execute("INSERT INTO Shop VALUES ('" + user_id + "', '" + itemid + "');");
            // upgrade
            sql.close();
          }
        }
      }
    }  // if the red button on our controller is pressed set the shop to false
  }

  boolean canUpgrade() { // currently one item, checks value against current coins
    boolean canUpgrade = false;
    int itemValue = 0;
    int coins = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM Money INNER JOIN Account ON Money.user_id = Account.user_id WHERE username='" + login.playerName + "';");
      if (sql.next()) {
        coins = sql.getInt("coins");
      }
      sql.query("SELECT * FROM Item WHERE name='Speed';");
      if (sql.next()) {
        itemValue = sql.getInt("value");
      }
      sql.query("SELECT * FROM Shop INNER JOIN Account ON Shop.user_id = Account.user_id WHERE username='" + login.playerName + "';");
      if (sql.next()) {
        canUpgrade = false;
      }
      sql.close();
      if (coins >= itemValue) {
        canUpgrade = true;
      }
    }
    return canUpgrade;
  }
}  
