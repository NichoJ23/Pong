enum Modes {INTRO, GAME, SCORED, GAMEOVER, OPTIONS, PAUSE, DIFFICULTY};
Modes mode;

PFont font;

Paddle leftPaddle, rightPaddle;

Ball ball;

int leftScore, rightScore;

boolean w, s, up, down;

ArrayList<Character> lettersDown;
ArrayList<Integer> keysDown;

color YELLOW = #FEFF86;
color GREY = #464646;

int scoredFrame;

boolean AIOn;
AI ai;

ArrayList<ButtonShell> introButtons;

void setup() {
  size(800, 800);
  
  rectMode(CENTER);
  
  mode = Modes.INTRO;
  
  font = createFont("beachday.ttf", 100);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  leftPaddle = new Paddle(new PVector(-1, height/2), 100);
  rightPaddle = new Paddle(new PVector(width + 1, height/2), 100);
  
  leftPaddle.fillColour = #B0DAFF;
  rightPaddle.fillColour = #19A7CE;
  
  ball = new Ball(new PVector(width/2, height/2), 5, 50);
  
  lettersDown = new ArrayList<Character>();
  keysDown = new ArrayList<Integer>();
  
  AIOn = true;
  ai = new AI(height/2, 1, Difficulty.INSANE);
  
  setupUI();
}

void draw() {
  switch (mode) {
    case INTRO:
      intro();
      break;
    case GAME:
      game();
      break;
    case SCORED:
      scored();
      break;
    case GAMEOVER:
      gameOver();
      break;
    case OPTIONS:
      options();
      break;
    case PAUSE:
      pause();
      break;
    case DIFFICULTY:
      difficulty();
      break;
    default:
      println("Error: " + mode + " is an invalid mode type");
  }
}

void setupUI() {
  introButtons = new ArrayList<ButtonShell>();
  
  Executable twoPlayer = () -> {mode = Modes.GAME; AIOn = false;};
  Executable singlePlayer = () -> {mode = Modes.DIFFICULTY; AIOn = true;};
  
  introButtons.add(new RectButton(width / 4, height * 3 / 4, 200, 100, #B0DAFF, GREY, 10, "1v1", twoPlayer));
}
