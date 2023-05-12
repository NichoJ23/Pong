class Paddle {
  PVector pos;
  float dia;
  color fillColour;
  color strokeColour;
  float strokeWeight;
  
  float moveSpeed;
  
  Paddle(PVector _pos, float _dia) {
    pos = _pos;
    dia = _dia;
    
    fillColour = #FFFFFF;
    strokeColour = #464646;
    strokeWeight = 10;
    
    moveSpeed = 7;
  }
  
  void display() {
    fill(fillColour);
    stroke(strokeColour);
    strokeWeight(strokeWeight);
    
    circle(pos.x, pos.y, dia);
  }
  
  void update(boolean moveUp, boolean moveDown) {
    if (moveUp) {
      pos.y -= moveSpeed;
      pos.y = max(0, pos.y);
    }
    
    if (moveDown) {
      pos.y += moveSpeed;
      pos.y = min(height, pos.y);
    }
  }
  
  float getRad() {
    return dia/2 + strokeWeight/2;
  }
}
