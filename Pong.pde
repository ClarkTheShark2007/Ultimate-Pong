Ball ball; // Define the ball as a global object

Paddle paddleLeft;
Paddle paddleRight;

int scoreLeft = 0;
int scoreRight = 0;

int roundScoreLeft = 0;
int roundScoreRight = 0;

int roundTimerSeccond = 5;

float paddleSpeed = 5.5;
int roundTimer = 0;
int roundCount = 0;

boolean gameStarted = false;
boolean roundEnded = false;
boolean gameEnd = false;

void setup() {
  size(800, 600, P2D);
  frameRate(60);
  ball = new Ball(width/2, height/2, 50); //create a new ball to the center of the window
  ball.speed.x = 5; // Giving the ball speed in x-axis
  ball.speed.y = random(-3, 3); // Giving the ball speed in y-axis

  paddleLeft = new Paddle(50, height/2, 30, 200);
  paddleRight = new Paddle(width-50, height/2, 30, 200);
}

void draw() {
  background(0); //clear canvas
  if (gameStarted == false) {
    titleScreen();
  } else if (roundEnded == true) {
    midScreen();
  } else {
    gameScreen();
  }
}

void titleScreen() {
  textSize(60);
  textAlign(CENTER);
  text("Ultimate Pong", width/2, height/2-60);
  textSize(30);
  text("Press any button to play", width/2, height/2+60);
  if (keyPressed == true) {
    gameStarted = true;
    resetRound();
  }
}

void roundTimerDisplay() {
  if (roundTimer <= 0) {
    if (scoreLeft == scoreRight) {
      textAlign(CENTER);
      fill(#D33C3C);
      text(0, width/2, 60);
      fill(255);
    } else {
      roundEnded = true;
      roundCount++;
    }
  } else {
    textSize(40);
    textAlign(CENTER);
    text((roundTimer/60), width/2, 60);
    roundTimer--;
  }
}

void midScreen() {
  textAlign(CENTER);
  if (roundScoreLeft >= 2)
  {
    gameEnd = true;
    text("Player 1 wins", width/2, height/2);
    textSize(40);
    text("Press any button for next round", width/2, height/2+60);
    if (keyPressed == true) {
      resetRound();
      gameStarted = false;
      gameEnd = false;
      roundScoreLeft = 0;
      roundScoreRight = 0;
      roundCount = 0;
    }
  } else {
    if (roundScoreRight >= 2)
    {
      gameEnd = true;
      text("Player 2 wins", width/2, height/2);
      textSize(40);
      text("Press any button for next round", width/2, height/2+60);
      if (keyPressed == true) {
        resetRound();
        gameStarted = false;
        gameEnd = false;
        roundScoreLeft = 0;
        roundScoreRight = 0;
        roundCount = 0;
      }
    }
  }

  if (scoreLeft > scoreRight && gameEnd == false)
  {
    println("Working");
    text("Player 1 wins round " + roundCount, width/2, height/2);
    textSize(40);
    text("Press any button for next round", width/2, height/2+60);
    if (keyPressed == true) {
      resetRound();
      roundScoreLeft++;
    }
  } else {
    if (scoreLeft < scoreRight && gameEnd == false)
    {
      text("Player 2 wins round " + roundCount, width/2, height/2);
      textSize(40);
      text("Press any button for menu", width/2, height/2+60);
      if (keyPressed == true) {
        resetRound();
        roundScoreLeft++;
      }
    }
  }
}

void resetRound() {
  roundTimer = roundTimerSeccond * 60;
  scoreLeft = 0;
  scoreRight = 0;
  roundEnded = false;
  gameEnd = false;
}

void gameScreen() {
  background(0); //clear canvas

  roundTimerDisplay();

  ball.display(); // Draw the ball to the window
  ball.move(); //calculate a new location for the ball
  ball.display(); // Draw the ball on the window

  paddleLeft.move();
  paddleLeft.display();
  paddleRight.move();
  paddleRight.display();


  if (ball.right() > width) {
    scoreLeft = scoreLeft + 1;
    ball.location.x = width/2;
    ball.location.y = height/2;
  }
  if (ball.left() < 0) {
    scoreRight = scoreRight + 1;
    ball.location.x = width/2;
    ball.location.y = height/2;
  }

  if (ball.bottom() > height) {
    ball.speed.y = -ball.speed.y;
  }

  if (ball.top() < 0) {
    ball.speed.y = -ball.speed.y;
  }

  if (paddleLeft.bottom() > height) {
    paddleLeft.location.y = height-paddleLeft.h/2;
  }

  if (paddleLeft.top() < 0) {
    paddleLeft.location.y = paddleLeft.h/2;
  }

  if (paddleRight.bottom() > height) {
    paddleRight.location.y = height-paddleRight.h/2;
  }

  if (paddleRight.top() < 0) {
    paddleRight.location.y = paddleRight.h/2;
  }


  // If the ball gets behind the paddle
  // AND if the ball is int he area of the paddle (between paddle top and bottom)
  // bounce the ball to other direction

  if ( ball.left() < paddleLeft.right() && ball.location.y > paddleLeft.top() && ball.location.y < paddleLeft.bottom()) {
    ball.speed.x = -ball.speed.x;
    ball.speed.y = map(ball.location.y - paddleLeft.location.y, -paddleLeft.h/2, paddleLeft.h/2, -10, 10);
  }

  if ( ball.right() > paddleRight.left() && ball.location.y > paddleRight.top() && ball.location.y < paddleRight.bottom()) {
    ball.speed.x = -ball.speed.x;
    ball.speed.y = map(ball.location.y - paddleRight.location.y, -paddleRight.h/2, paddleRight.h/2, -10, 10);
  }

  textSize(40);
  textAlign(CENTER);
  text(scoreRight, width/2+30, 30); // Right side score
  text(scoreLeft, width/2-30, 30); // Left side score
}

void keyPressed() {
  if (keyCode == UP) {
    paddleRight.speed.y=(paddleSpeed*-1);
  }
  if (keyCode == DOWN) {
    paddleRight.speed.y=paddleSpeed;
  }
  if (key == 'w') {
    paddleLeft.speed.y=(paddleSpeed*-1);
  }
  if (key == 's') {
    paddleLeft.speed.y=paddleSpeed;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    paddleRight.speed.y=0;
  }
  if (keyCode == DOWN) {
    paddleRight.speed.y=0;
  }
  if (key == 'w') {
    paddleLeft.speed.y=0;
  }
  if (key == 's') {
    paddleLeft.speed.y=0;
  }
}
