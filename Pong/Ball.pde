class Ball {
  PVector pos;
  PVector dir;
  float speed;
  float xSpeed;
  float startSpeed;
  float speedCap;
  float speedInc;
  float dia;
  
  color fillColour;
  color strokeColour;
  float strokeWidth;
  
  Ball(PVector _pos, float _speed, float _dia) {
    pos = _pos;
    dir = randomDir();
    speed = xSpeed = startSpeed = _speed;
    speedInc = 0.2;
    speedCap = 20;
    dia = _dia;
    
    fillColour = #146C94;
    strokeColour = GREY;
    strokeWidth = 10;
  }
  
  void display() {
    fill(fillColour);
    stroke(strokeColour);
    strokeWeight(strokeWidth);
    
    circle(pos.x, pos.y, dia);
  }
  
  void update() {
    pos.add(PVector.mult(dir, speed));
    
    if (pos.y - getRad() < 0 || pos.y + getRad() > height) {
      dir.y *= -1;
      pos.add(PVector.mult(dir, speed));
    }
    
    if (dist(pos.x, pos.y, leftPaddle.pos.x, leftPaddle.pos.y) < getRad() + leftPaddle.getRad()) {
      dir = PVector.sub(pos, leftPaddle.pos).normalize();
      speed = min(speedCap, xSpeed / abs(dir.x));
      xSpeed += speedInc;
      pos.add(PVector.mult(dir, speed));
    }
    
    if (dist(pos.x, pos.y, rightPaddle.pos.x, rightPaddle.pos.y) < getRad() + rightPaddle.getRad()) {
      dir = PVector.sub(pos, rightPaddle.pos).normalize();
      speed = min(speedCap, xSpeed / abs(dir.x));
      xSpeed += speedInc;
      pos.add(PVector.mult(dir, speed));
    }
    
    if (pos.x < -getRad()) {
      rightScore++;
      mode = Modes.SCORED;
      scoredFrame = frameCount;
      reset();
    }
    
    if (pos.x > width + getRad()) {
      leftScore++;
      mode = Modes.SCORED;
      scoredFrame = frameCount;
      reset();
    }
  }
  
  void reset() {
    pos = new PVector(width / 2, height / 2);
    speed = xSpeed = startSpeed;
    dir = randomDir();
    leftPaddle.pos.y = rightPaddle.pos.y = ai.yPos = height/2;
    ai.yVel = 0;
  }
  
  float getRad() {
    return dia/2 + strokeWidth/2;
  }
  
  PVector randomDir() {
    float vx = random(0.3, 1) * -1;//(int)random(0, 2) * 2 - 1;
    float vy = sqrt(1 - vx*vx);
    
    return new PVector(vx, vy);
  }
}
