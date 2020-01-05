// als de speler dood gaat voeg 1 toe aan total runs 
// een variable die aantal killed enemies optelt 
// een variable die aantal killed bosses optelt 
// personal highscore 
// andere scores die je ooit gehaalt hebt 
// een tabel waar elke run gesaved wordt met user, aantal enemies killed, aantal bosses killed en huidige score 
// een tabel waar alle metrics opgeslagen worden met user, total enemies killed, total bosses killed, personal highscore en total runs 
class Metrics { 
  boolean showStatistics; 
  int totalRuns = 10;

  void drawStatistics() { // Draw the actual statistics 
    if (showStatistics) { 
      fill(127);
      stroke(5);
      rect(320, 200, 640, 720);
      stroke(3);
      textSize(50);
      fill(0); 
      text("Name: " + login.playerName, width/2, 250);
      textSize(25);
      text("You played: "+totalRuns,width/2, 275);
    }
  }
  
  void pressedKey() { 
    if (key == 'o' || key == 'O') { 
      showStatistics = true;
    } else if (key == 'p') { 
      showStatistics = false;
    } 
  }
}
