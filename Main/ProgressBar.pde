class ProgressBar {
  final PVector PROGRESSBARPOS;
  final int BARLENGTH;
  final int BARHEIGHT;
  final float UPDATESCORECOUNTER = 1.25;
  final int PROGRESSBARIMAGESIZE = 25;  
  final PVector SKULLPOS = new PVector(975, 6);
  PVector progression = new PVector(0, 6);
  PVector progressBarImagePos = new PVector(300, 6);
  float scoreCounter = 1.25;
  HighScore highscore;

  ProgressBar(PVector PROGRESSBARPOS, int BARLENGTH, int BARHEIGHT) {
    this.PROGRESSBARPOS = PROGRESSBARPOS;
    this.BARLENGTH = BARLENGTH;
    this.BARHEIGHT = BARHEIGHT;
  }
  void drawProgressBar() {
    fill(255, 0, 0);
    rect(PROGRESSBARPOS.x-5, PROGRESSBARPOS.y-5, PROGRESSBARPOS.x+BARLENGTH+10, PROGRESSBARPOS.y+BARHEIGHT+10);

    fill(100, 100, 100);
    rect(PROGRESSBARPOS.x, PROGRESSBARPOS.y, PROGRESSBARPOS.x+BARLENGTH, PROGRESSBARPOS.y+BARHEIGHT);
    fill(0, 220, 0);
    rect(PROGRESSBARPOS.x, PROGRESSBARPOS.y, progression.x+PROGRESSBARIMAGESIZE, PROGRESSBARPOS.y+BARHEIGHT);
    image(skull, SKULLPOS.x, SKULLPOS.y);
    image(skinCorra, progressBarImagePos.x, progressBarImagePos.y, PROGRESSBARIMAGESIZE, PROGRESSBARIMAGESIZE);

    updateProgressBar();

    //println(boss.isDead);
  }

  void updateProgressBar() {
    if (highScore.highScore > scoreCounter && !boss.bossOnScreen) {
      scoreCounter += UPDATESCORECOUNTER;
      progressBarImagePos.x+= 1.64;
      progression.x += 1.64;
    }
    if (boss.isDead) {
      progressBarImagePos.x = 300;
      progression.x = 0;
    }
  }
}
