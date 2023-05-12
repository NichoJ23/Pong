void mousePressed() {
  switch (mode) {
    case INTRO:
      introClicks();
      break;
    case GAME:
      gameClicks();
      break;
    case SCORED:
      scoredClicks();
      break;
    case GAMEOVER:
      gameOverClicks();
      break;
    case OPTIONS:
      optionsClicks();
      break;
    case PAUSE:
      pauseClicks();
      break;
    case DIFFICULTY:
      difficultyClicks();
      break;
    default:
      println("Error: " + mode + " is an invalid mode type");
  }
}

void keyPressed() {
  if (key == 'w') w = true;
  if (key == 's') s = true;
  if (keyCode == UP) up = true;
  if (keyCode == DOWN) down = true;
  if (key == 'p') mode = Modes.PAUSE;
}

void keyReleased() {
  if (key == 'w') w = false;
  if (key == 's') s = false;
  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (key == 'p') mode = Modes.GAME;
}
