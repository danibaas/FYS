class Shop {
  PVector icon = new PVector(1100, 10);
  boolean showShop;

  // Constants
  final int ACHIEVED_AMOUNT_X = 900;
  final int ACHIEVED_AMOUNT_Y = 160;
  final int UPGRADE_COST_X = 650;
  final int UPGRADE_COST_Y = 180;
  final int UPGRADE_X = 650;
  final int UPGRADE_Y = 150;
  final int UPGRADE_IMAGE_X = 210;
  final int UPGRADE_IMAGE_Y = 110;
  final int OUTER_LAYER_X = 200;
  final int OUTER_LAYER_Y = 100;
  final int OUTER_LAYER_WIDTH = 800;
  final int OUTER_LAYER_HEIGHT = 500;
  final int INNER_LAYER_X = 210;
  final int INNER_LAYER_Y = 110;
  final int INNER_LAYER_WIDTH = 780;
  final int INNER_LAYER_HEIGHT = 100;

  // Method om alles in de database te zetten wat nodig is
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
        sql.execute("INSERT INTO Inventory VALUES (" + userid + ", " + itemid + ");");
      } else {
        sql.query("SELECT * FROM ((Inventory INNER JOIN Account ON Inventory.user_id = Account.user_id) INNER JOIN Item ON Inventory.itemid = Item.itemid) WHERE username='" + login.playerName + "';");   
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
          sql.execute("INSERT INTO Inventory VALUES (" + userid + ", " + itemid + ");");
        }
      }
      sql.close();
    }
  }

  // Method om het aantal users op te halen dat het item heeft met het gegeven itemid
  int getUserAmount(int itemid) { // get the amount of users that have the item
    int amount = 0;
    if (sql.connect()) {
      sql.query("SELECT COUNT(user_id) FROM Inventory WHERE itemid='" + itemid + "' GROUP BY itemid;");
      if (sql.next()) {
        amount = sql.getInt("COUNT(user_id)");
      }
      sql.close();
    }
    return amount;
  }

  // Method om shop met upgrades erin te tekenen
  void drawShop() {
    if (showShop) {
      fill(200);
      rect(OUTER_LAYER_X, OUTER_LAYER_Y, OUTER_LAYER_WIDTH, OUTER_LAYER_HEIGHT);
      stroke(5);
      fill(210);
      rect(INNER_LAYER_X, INNER_LAYER_Y, INNER_LAYER_WIDTH, INNER_LAYER_HEIGHT);
      image(speed_upgrade, UPGRADE_IMAGE_X, UPGRADE_IMAGE_Y);
      if (canUpgrade()) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      text("Speed Upgrade", UPGRADE_X, UPGRADE_Y);
      text("500", UPGRADE_COST_X, UPGRADE_COST_Y);
      textSize(18);
      text("Achieved " + getUserAmount(1) + " time(s)!", ACHIEVED_AMOUNT_X, ACHIEVED_AMOUNT_Y);
      fill(255);
      textAlign(CENTER);
      textSize(22);
      text("Press A to go back", width/2, 580);
    }
  }

  // Method om icon te tekenen die de shop opent
  void drawIcon() {
    tint(200, 200);
    image(shopIcon, icon.x, icon.y);
    noTint();
  }

  // Method om de pressed keys te checken
  void pressedKey() {
    if (key == 'c' || key == 'C') {
      showShop = true;
    } else if (key == 'b' || key == 'B') {
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
            sql.query("SELECT * FROM Account WHERE user_id='" + userid + "';");
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
            sql.execute("UPDATE Account SET coins='" + totalCoins + "';");
            sql.execute("INSERT INTO Inventory VALUES ('" + user_id + "', '" + itemid + "');");
            // upgrade
            sql.close();
          }
        }
      }
    }
  }

  boolean canUpgrade() { // currently one item, checks value against current coins
    boolean canUpgrade = false;
    int itemValue = 0;
    int coins = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE username='" + login.playerName + "';");
      if (sql.next()) {
        coins = sql.getInt("coins");
      }
      sql.query("SELECT * FROM Item WHERE name='Speed';");
      if (sql.next()) {
        itemValue = sql.getInt("value");
      }
      sql.query("SELECT * FROM Inventory INNER JOIN Account ON Inventory.user_id = Account.user_id WHERE username='" + login.playerName + "';");
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
