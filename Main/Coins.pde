class Money implements Updater {
  int coins;
  final int TOP_ROW = 1, SEMI_MID_ROW = 3, MID_ROW = 5, WAIT_TIME = 1000;
  final int COIN_ACTIVE_X = 1120;
  final int COIN_ACTIVE_Y = 80;
  final int COIN_INACTIVE_X = 640;
  final int COIN_INACTIVE_Y = 30;
  final int RESPAWN_POSITION = 10000;
  final int RICHEST = 5;
  ArrayList<Coin> allCoins = new ArrayList();

  Money() {
    updateList.add(this);
    for (int i = 0; i < TOP_ROW; i++) {
      Coin coins = new Coin(new PVector(500 + 50*i, 400), COIN_SIZE, COIN_SIZE);
      allCoins.add(coins);
    }
    for (int i = 0; i < SEMI_MID_ROW; i++) {
      Coin coins = new Coin(new PVector(450 + 50*i, 450), COIN_SIZE, COIN_SIZE);
      allCoins.add(coins);
    }
    for (int i = 0; i < MID_ROW; i++) {
      Coin coins = new Coin(new PVector(400 + 50*i, 500), COIN_SIZE, COIN_SIZE);
      allCoins.add(coins);
    }
    for (int i = 0; i < SEMI_MID_ROW; i++) {
      Coin coins = new Coin(new PVector(450 + 50*i, 550), COIN_SIZE, COIN_SIZE);
      allCoins.add(coins);
    }
    for (int i = 0; i < TOP_ROW; i++) {
      Coin coins = new Coin(new PVector(500 + 50*i, 600), COIN_SIZE, COIN_SIZE);
      allCoins.add(coins);
    }
  }

  void drawObject() {
    for (Coin coin : allCoins) {
      coin.drawCoin();
    }
    if (!screenActive) {
      fill(212, 175, 55);
      textSize(30);
      text("Coins: " + coins, COIN_ACTIVE_X, COIN_ACTIVE_Y);
    } else {
      fill(212, 175, 55);
      textSize(30);
      text("Coins: " + loadCoins(), COIN_INACTIVE_X, COIN_INACTIVE_Y);
    }
  }

  void updateObject() {
    for (Coin coin : allCoins) {
      coin.updateCoin(); 
      if (coin.position.x + coin.boxWidth < 0) {
        coin.position.x = RESPAWN_POSITION;
        coin.draw = true;
      }
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void saveCoins() {
    String name = login.playerName;
    int userId = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE username='" + name + "';"); 
      if (sql.next()) {
        int savedCoins = sql.getInt("coins");
        int totalCoins = savedCoins + coins;
        sql.execute("UPDATE Account SET coins='" + totalCoins + "' WHERE user_id='" + userId + "';");
      } 
      println("Coins Saved!");
      sql.close();
    }
  }

  int loadCoins() {
    int coinAmount = 0;
    String name = login.playerName;
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE username='" + name + "';");
      if (sql.next()) {
        coinAmount = sql.getInt("coins");
      }
      sql.close();
    }
    return coinAmount;
  }

  ArrayList<String> getRichest() {
    ArrayList<String> names = new ArrayList();
    if (sql.connect()) {
      sql.query("SELECT coins FROM Account ORDER BY coins ASC;");
      for (int i = 0; i < RICHEST; i++) {
        if (sql.next()) {
          names.add(sql.getString("username"));
        } else {
          break;
        }
      }
      sql.close();
    }
    return names;
  }

  void deletePerson(String userid) {
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE user_id='" + userid + "';");
      if (sql.next()) {
        sql.execute("DELETE FROM Account WHERE user_id='" + userid + "';");
      }
      println("Deleted " + userid + " from table Account");
      sql.close();
    }
  }
}

class Coin extends Collider {
  PVector position;
  final int COIN_INCREMENT = 5;
  boolean draw = true, collectedLastFrame;

  Coin(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight);
    this.position = position;
  }

  void drawCoin() {
    if (draw) {
      image(coin, position.x, position.y);
    }
    collectedLastFrame = false;
  }

  void updateCoin() {
    if (collidesWithPlayer(player) && draw && !collectedLastFrame) {
      coinPickup.play();
      money.coins += COIN_INCREMENT;
      draw = false;
      collectedLastFrame = true;
    }
    if (keys[2]) {
      moveEntity();
    }
  }
}
