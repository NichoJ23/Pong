void scored() {
  background(YELLOW);
  
  fill(GREY);
  textSize(50);
  textAlign(CENTER, CENTER);
  text(leftScore + "", width / 4, height / 4);
  text(rightScore + "", width * 3 / 4, height / 4);
  
  rectMode(CORNER);
  for (int y = -25; y < height; y += 150) {
    rect(width/2 - 5, y, 10, 100);
  }
  rectMode(CENTER);
  
  leftPaddle.display();
  rightPaddle.display();
  
  if ((frameCount - scoredFrame) % 60 < 30) {
    ball.display();
  }
  
  if (frameCount - scoredFrame >= 149) {
    mode = Modes.GAME;
  }
  scoredUI();
}

void scoredUI() {
  
}

void scoredClicks() {
  
}
