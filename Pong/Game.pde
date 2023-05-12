void game() {
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
  
  ball.update();
  leftPaddle.update(w, s);
  if (AIOn) {
    ai.update();
    rightPaddle.pos.y = ai.yPos;
  } else {
    rightPaddle.update(up, down);
  }
  
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
  
  gameUI();
}

void gameUI() {
  
}

void gameClicks() {
  
}
