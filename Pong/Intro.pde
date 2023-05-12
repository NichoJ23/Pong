void intro() {
  background(YELLOW);
  
  fill(GREY);
  textSize(300);
  text("PONG", width/2, 200);
  
  
  introUI();
}

void introUI() {
  for (ButtonShell b: introButtons) {
    b.display();
  }
}

void introClicks() {
  for (ButtonShell b: introButtons) {
    b.checkClick();
  }
}
