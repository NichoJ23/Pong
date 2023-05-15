class Ball {
  PVector pos;
  PVector dir;
  float speed;
  float xSpeed;
  float startSpeed;
  float speedCap;
  float speedInc;
  float dia;
  float initialSpeed;
  
  color fillColour;
  color strokeColour;
  float strokeWidth;
  
  Ball(PVector _pos, float _initialSpeed, float _speed, float _dia) {
    pos = _pos;
    dir = randomDir();
    speedCap = 20;
    initialSpeed = _initialSpeed;
    speed = min(speedCap, initialSpeed / abs(dir.x));
    xSpeed = startSpeed = _speed;
    speedInc = 0.2;
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
      
      if (rightScore >= winThreshold) {
        mode = Modes.GAMEOVER;
        winner = "RIGHT";
      } else {
        mode = Modes.SCORED;
        scoredFrame = frameCount;
        reset();
      }
    }
    
    if (pos.x > width + getRad()) {
      leftScore++;
      
      if (leftScore >= winThreshold) {
        mode = Modes.GAMEOVER;
        winner = "LEFT";
      } else {
        mode = Modes.SCORED;
        scoredFrame = frameCount;
        reset();
      }
    }
  }
  
  void reset() {
    pos = new PVector(width / 2, height / 2);
    xSpeed = startSpeed;
    dir = randomDir();
    speed = min(5, initialSpeed / abs(dir.x));
    leftPaddle.pos.y = rightPaddle.pos.y = ai.yPos = height/2;
    ai.yVel = 0;
  }
  
  float getRad() {
    return dia/2 + strokeWidth/2;
  }
  
  PVector randomDir() {
    float vx = random(0.3, 1) * ((int)random(0, 2) * 2 - 1);
    float vy = sqrt(1 - vx*vx) * ((int)random(0, 2) * 2 - 1);
    
    println(new PVector(vx, vy).mag());
    println(vx);
    println(vy);
    return new PVector(vx, vy);
  }
}
