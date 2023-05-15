import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

enum Modes {INTRO, GAME, SCORED, GAMEOVER, OPTIONS, PAUSE, DIFFICULTY};
Modes mode;

PFont font;

Minim minim;
AudioPlayer wall, victory, score, rightPaddleSound, leftPaddleSound, clapping, intro;

Paddle leftPaddle, rightPaddle;

Ball ball;

int leftScore, rightScore;
int winThreshold;
String winner;

boolean w, s, up, down;

ArrayList<Character> lettersDown;
ArrayList<Integer> keysDown;

color YELLOW = #FEFF86;
color GREY = #464646;

int scoredFrame;

boolean AIOn;
AI ai;

ArrayList<ButtonShell> introButtons, difficultyButtons, gameOverButtons;

void setup() {
  size(800, 800);
  
  rectMode(CENTER);
  
  mode = Modes.INTRO;
  
  font = createFont("beachday.ttf", 100);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  minim = new Minim(this);
  wall = minim.loadFile("wall.wav");
  victory = minim.loadFile("victory.mp3");
  score = minim.loadFile("score.wav");
  leftPaddleSound = minim.loadFile("leftPaddle.wav");
  rightPaddleSound = minim.loadFile("rightPaddle.wav");
  clapping = minim.loadFile("clapping.wav");
  intro = minim.loadFile("intro.wav");
  
  leftPaddle = new Paddle(new PVector(-1, height/2), 100);
  rightPaddle = new Paddle(new PVector(width + 1, height/2), 100);
  
  leftPaddle.fillColour = #B0DAFF;
  rightPaddle.fillColour = #19A7CE;
  
  ball = new Ball(new PVector(width/2, height/2), 2, 5, 50);
  
  leftScore = rightScore = 0;
  winThreshold = 1;
  winner = "";
  
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
  difficultyButtons = new ArrayList<ButtonShell>();
  gameOverButtons = new ArrayList<ButtonShell>();
  
  Executable twoPlayer = () -> {mode = Modes.GAME; AIOn = false;};
  Executable singlePlayer = () -> {mode = Modes.DIFFICULTY; AIOn = true;};
  
  Executable easyAI = () -> {ai.difficulty = Difficulty.EASY; mode = Modes.GAME;};
  Executable insaneAI = () -> {ai.difficulty = Difficulty.INSANE; mode = Modes.GAME;};
  
  Executable playAgain = () -> {rematch();};
  Executable menu = () -> {backToMenu();};
  
  introButtons.add(new RectButton(width / 4, height * 3 / 4, 300, 150, #B0DAFF, GREY, 10, "1v1", twoPlayer));
  introButtons.add(new RectButton(width * 3 / 4, height * 3 / 4, 300, 150, #B0DAFF, GREY, 10, "AI", singlePlayer));
  
  difficultyButtons.add(new RectButton(width / 4, height / 2, 300, 150, #B0DAFF, GREY, 10, "EASY", easyAI));
  difficultyButtons.add(new RectButton(width *3 / 4, height / 2, 300, 150, #B0DAFF, GREY, 10, "INSANE", insaneAI));
  
  gameOverButtons.add(new RectButton(width / 4, height * 3 / 4, 300, 150, #B0DAFF, GREY, 10, "AGAIN", playAgain));
  gameOverButtons.add(new RectButton(width * 3 / 4, height * 3 / 4, 300, 150, #B0DAFF, GREY, 10, "MENU", menu));
}

void rematch() {
  mode = Modes.GAME;
  
  leftScore = rightScore = 0;
  leftPaddle.pos.y = rightPaddle.pos.y = height / 2;
  ball.reset();
  
  
}

void backToMenu() {
  mode = Modes.INTRO;
  
  leftScore = rightScore = 0;
  leftPaddle.pos.y = rightPaddle.pos.y = height / 2;
  ball.reset();
  
  AIOn = false;
  ai.yPos = height / 2;
  
  intro.rewind();
}
