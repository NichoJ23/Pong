void difficulty() {
  background(YELLOW);
  
  
  difficultyUI();
}

void difficultyUI() {
  for (ButtonShell b: difficultyButtons) {
    b.display();
  }
}

void difficultyClicks() {
  for (ButtonShell b: difficultyButtons) {
    b.checkClick();
  }
}
