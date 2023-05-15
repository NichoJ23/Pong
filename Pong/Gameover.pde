void gameOver() {
  background(YELLOW);
  
  gameOverUI();
}

void gameOverUI() {
  for (ButtonShell b: gameOverButtons) {
    b.display();
  }
  
  fill(GREY);
  
  textSize(150);
  text(winner + " WINS!", width / 2, height * 0.25);
  
  textSize(100);
  text("Score: " + leftScore + "-" + rightScore, width / 2, height * 0.45);
}

void gameOverClicks() {
  for (ButtonShell b: gameOverButtons) {
    b.checkClick();
  }
}
