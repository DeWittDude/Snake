/*
  ~Controls~
  SPACEBAR - change color
  UP/DOWN ARROW KEYS - change the length of the snake
  LEFT/RIGHT ARROW KEYS - change the width of the snake
  
  Welcome!

  This is my first official program is Processing (It's less than 100 lines)
  Hope you enjoy!
  
  -DeWittDude
*/


//customize these variables (self explanatory)
int snakeLength = 500;
int[] snakeLengthLimit = {100, 1000};
int snakeThickness = 20;
int[] snakeThicknessLimit = {1, 50};
int numOfColors = 3;
//setting up arrays for positions to draw the snake and the colors (I would've used PVectors but I can't splice a PVector Array
float[] xPositions = new float[snakeLength];
float[] yPositions = new float[snakeLength];
color[] snakeColors = new color[numOfColors];

//setting up variables for calculating fps
float fps;
int startFrame;
int startTime;

void setup() {
  
  //sets window size
  size(600, 600);
  
  //fills lists so they aren't marked "empty" (default mouse position is (0, 0)
  for (int i = 0; i < snakeLength; i ++) {
  
    xPositions[i] = mouseX;
    yPositions[i] = mouseY;
}
  //selects random snake colors
  for (int i = 0; i < numOfColors; i ++) {
    
    snakeColors[i] = color(random(255), random(255), random(255));
  }
}

void draw() {
  frameRate(2147483647); // for maximum framerate possible, here is the max value for int variable type
  
  //calculates framerate every 100 frames
  if (frameCount % 100 == 0) {
        float time = millis() - startTime;
        int frame = frameCount - startFrame;
        
        fps = frame / (time / 1000);
        fps = floor(fps * 100) / 100;
        
        startTime = millis();
        startFrame = frameCount;
  }
  //inputs new mouse positions to the beginning of the lists
  xPositions = splice(xPositions, mouseX, 0);
  yPositions = splice(yPositions, mouseY, 0);
  
  //sets background to a dark grey
  background(20);
  
  
  
  //draw snake
  for (int i = snakeLength; i > 0; i --) {
    
    strokeWeight(snakeThickness);
    stroke(snakeColors[floor(i / 16) % snakeColors.length]);
    line(xPositions[i - 1], yPositions[i - 1], xPositions[i], yPositions[i]);
  }
  
  //displays the fps in the top left of window
  fill(255, 255, 255);
  textSize(30);
  textAlign(LEFT, TOP);
  text("FPS : " + fps, 10, 10);
  
  //display snake stats
  textSize(12);
  textAlign(RIGHT, TOP);
  text("Snake Length : " + snakeLength, width - 10, 10);
  text("Snake Thickness : " + snakeThickness, width - 10, 24);
  text("Number of Colors : " + numOfColors, width - 10, 38);
  inputRestrictions();
}

void updateColor() {
  
  println("color changed!");
  snakeColors = new color[numOfColors];
  for (int i = 0; i < numOfColors; i ++) {
    snakeColors[i] = color(random(255), random(255), random(255));
  }
}

void inputRestrictions() {
  
  //restrict snake length
  if (snakeLength < snakeLengthLimit[0]) {
    
    snakeLength = snakeLengthLimit[0];
  } else
  if (snakeLength > snakeLengthLimit[1]) {
    
    snakeLength = snakeLengthLimit[1];
  }
  //restrict snake thickness
  if (snakeThickness < snakeThicknessLimit[0]) {
    
    snakeThickness = snakeThicknessLimit[0];
  } else
  if (snakeThickness > snakeThicknessLimit[1]) {
    
    snakeThickness = snakeThicknessLimit[1];
  }
}

void keyPressed() {
  
  //change colors when the space key is pressed
  if (key == ' ') {
    updateColor();
  }
  //change length with UP and DOWN arrow keys
  if (!(keyCode == UP && keyCode == DOWN)) {
    
    if (keyCode == UP) {
      
      snakeLength ++;
    }
    if (keyCode == DOWN) {
      
      snakeLength --;
    }
  }
  //change thickness with LEFT and RIGHT arrow keys
  if (!(keyCode == RIGHT && keyCode == LEFT)) {
    
    if (keyCode == RIGHT) {
      
      snakeThickness ++;
    }
    if (keyCode == LEFT) {
      
      snakeThickness --;
    }
  }
  //change number of colors with SHIFT and CONTROL arrow keys
  if (!(keyCode == SHIFT && keyCode == CONTROL)) {
    
    if (keyCode == SHIFT) {
      
      numOfColors ++;
      updateColor();
    }
    if (keyCode == CONTROL) {
      
      numOfColors --;
      updateColor();
    }
  }
}
