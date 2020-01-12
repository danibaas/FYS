class Money implements Updater {
  int coins;

  // Constanten
  final int TOP_ROW = 1, SEMI_MID_ROW = 3, MID_ROW = 5, WAIT_TIME = 1000;
  final int COIN_ACTIVE_X = 1120;
  final int COIN_ACTIVE_Y = 80;
  final int COIN_INACTIVE_X = 640;
  final int COIN_INACTIVE_Y = 30;
  final int RESPAWN_POSITION = 10000;
  final int RICHEST = 5;
  ArrayList<Coin> allCoins = new ArrayList();

  // Constructor
  Money() {
    updateList.add(this); // Voeg toe aan de updatelist zodat de update en draw etc uitgevoerd worden
    for (int i = 0; i < TOP_ROW; i++) { // Deze for loops zijn voor het maken van de rijen om de coins vorm te geven
      Coin coins = new Coin(new PVector(500 + 50*i, 400), COIN_SIZE, COIN_SIZE);
      allCoins.add(coins); // Voeg ze allemaal toe aan de arraylist
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

  // Parent method om te tekenen 
  void drawObject() {
    for (Coin coin : allCoins) { // Voor elke coin in de arraylist, doe...
      coin.drawCoin(); // tekenen
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

  // Parent method om te updaten
  void updateObject() {
    for (Coin coin : allCoins) { // Voor elke coin in de arraylist, doe...
      coin.updateCoin();  // updaten
      if (coin.position.x + coin.boxWidth < 0) { // en als ze buiten het scherm zijn, respawn ze
        coin.position.x = RESPAWN_POSITION;
        coin.draw = true;
      }
    }
  }

  // Parent method
  void pressedKey() {
  }

  // Parent method
  void releasedKey() {
  }

  // Sla de coins op in de database 
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
      sql.close();
    }
  }

  // Laad de coins vanuit de database
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

  // Haal het aantal rijkste met op vanuit de database en geef deze terug in de vorm van een arraylist
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

  // Verwijder iemand van de database
  void deletePerson(String userid) {
    if (sql.connect()) {
      sql.query("SELECT * FROM Account WHERE user_id='" + userid + "';");
      if (sql.next()) {
        sql.execute("DELETE FROM Account WHERE user_id='" + userid + "';");
      }
      sql.close();
    }
  }
}

class Coin extends Collider {
  PVector position;
  boolean draw = true, collectedLastFrame;

  // Constanten
  final int COIN_INCREMENT = 5;

  // Constructor
  Coin(PVector position, float boxWidth, float boxHeight) {
    super(position, boxWidth, boxHeight); // Geef de data door aan de constructor van de parent class (collider)
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
