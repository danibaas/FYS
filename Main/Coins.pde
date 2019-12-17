class Money implements Updater {
  int coins;
  final int TOP_ROW = 1, SEMI_MID_ROW = 3, MID_ROW = 5, WAIT_TIME = 1000;
  ArrayList<Coin> allCoins = new ArrayList();
  HashMap<Integer, Boolean> saved = new HashMap();

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
    fill(212, 175, 55);
    textSize(30);
    text("Coins: " + coins, 1110, 80);
  }

  void updateObject() {
    for (Coin coin : allCoins) {
      coin.updateCoin(); 
      if (coin.position.x + coin.boxWidth < 0) {
        coin.position.x = 10000;
        coin.draw = true;
      }
    }
    if (!saved.containsKey(coins)) {
      saved.put(coins, false);
    }
  }

  void pressedKey() {
  }

  void releasedKey() {
  }

  void saveCoins() {
    if (!saved.containsKey(coins) || !saved.get(coins)) {
      String name = login.playerName;
      int userId = 0;
      if (sql.connect()) {
        sql.query("SELECT * FROM Account WHERE username='" + name + "';"); 
        if (sql.next()) {
          userId = sql.getInt("user_id");
        }
        sql.execute("INSERT INTO Money VALUES ('" + userId + "', '" + coins + "');");
        println("Coins Saved!");
        sql.close();
      }
      saved.put(coins, true);
    }
  }

  int loadCoins() {
    int coinAmount = 0;
    String name = login.playerName;
    int userId = 0;
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE username='" + name + "';");
      if (sql.next()) {
        userId = sql.getInt("user_id");
      }
      sql.query("SELECT * FROM Money WHERE user_id='" + userId + "';");
      if (sql.next()) {
        coinAmount = sql.getInt("coins");
      }
      sql.close();
    }
    return coinAmount;
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
      money.coins += COIN_INCREMENT;
      draw = false;
      collectedLastFrame = true;
    }
    if (keys[2]) {
      moveEntity();
    }
  }
}
