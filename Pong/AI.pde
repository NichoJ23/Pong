enum Difficulty {EASY, HARD, INSANE};

class AI {
  float yPos;
  float yVel;
  float yAcc;
  float targetY;
  Difficulty difficulty;
  
  AI(float _yPos, float _yAcc, Difficulty _difficulty) {
    yPos = _yPos;
    yVel = 0;
    yAcc = _yAcc;
    difficulty = _difficulty;
  }
  
  void update() {
    switch (difficulty) {
      case EASY:
        targetY = easy();
        break;
      case HARD:
        hard();
        break;
      case INSANE:
        targetY = insane();
        break;
      default:
        println(difficulty + " is not a valid difficulty setting");
    }
    
    if (targetY > yPos) {
      yVel += yAcc;
    } else if (targetY < yPos) {
      yVel -= yAcc;
    }
    
    yVel *= 0.9;
    yVel = min(yVel, abs(yPos - targetY));

    if (abs(yPos + yVel - targetY) > 1) {
      yPos += yVel;
    } else {
      yPos = targetY;
    }

  }
  
  float easy() {
    if (ball.pos.x < width / 4) return yPos;
    
    return ball.pos.y;
  }
  
  void hard() {
    
  }
  
  float insane() {
    if (ball.dir.x < 0) return yPos;
    
    float distX = width - ball.getRad() - ball.pos.x;
    PVector change = PVector.mult(ball.dir, distX / ball.dir.x);
    PVector targetPos = PVector.add(ball.pos, change);
    float bounds = height - ball.getRad() * 2;
    
    int flips;
    if (targetPos.y >= 0) {
      flips = (int)((targetPos.y - ball.getRad()) / bounds);
    } else {
      flips = 1 + (int)((abs(targetPos.y) + ball.getRad()) / bounds);
    }
    int totalFlips = flips;
    
    float targetPosY = targetPos.y;
    
    float remainingY = (targetPosY - ball.getRad()) % bounds + ball.getRad();// + ball.getRad();
    //remainingY *= ((targetPosY < 0) ? -1: 1);
    
    if (remainingY < 0) {
      if (remainingY / bounds >= 1) {
        remainingY += bounds;
        remainingY *= -1;
      } else {
        remainingY =  -remainingY + 2*ball.getRad();
      }
      flips -= 1;
    }
    if (flips % 2 == 1) {
      remainingY = bounds - remainingY + 2*ball.getRad() + 1;
    }
    
    float side = (ball.dir.y * pow(-1, totalFlips) > 0) ? 1: -1;
    return remainingY + 1.3 * rightPaddle.getRad() * side;
  }
}
