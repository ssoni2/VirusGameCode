/*****
* first draft/base of virus game
*
* controls so far:
* wasd -move
* space -start game
* \ -reset game
*****/

/**
* global variables
* -can be used by any class
* -please prefix with $ for consistency
*/
Boolean[] $dir = new Boolean[4]; //array that tracks which arrow keys are hit
Boolean[] $mov = new Boolean[4]; //array that tracks movement
Boolean[] $action = new Boolean[2]; //array that tracks which of the other keys are hit
Images $images; //holds all game images
String $mode; //controls flow of the game
int $xPriority, $yPriority; //assigns priority if left+right or up+down is held
Cell $cell; //main character
TileMap $tileMap; //background map
TileMap $objMap; //objects on the map
int $rows, $cols; //amount of rows and columns per screen
int $rowMap, $colMap; //map index
int $rowMapInit, $colMapInit; //initial index of map you're on
int $tSize; //size of an individual tile
int $lim; //controlls scrolling speed on screen transitions
int $frame; //frame of scrolling
/**
* temp
*/
int[] $bg = new int[3]; //makes bg random color. different every time you reset

/**
* first thing ran before going to draw()
* -only initiate things that need to be done once
*/
void setup() {
  size(864,486); //aspect ration
  $images = new Images(); //initiate class to load all game images
  //change these if you want
  $rows = 9; 
  $cols = 12;
  $tSize = 54;
  reset();
}

/**
* function that allows for resetting the game to be convenient
* set initial values here
*/
void reset() {
  $frame = 0;
  $rowMap = $colMap = 0;
  $rowMapInit = $colMapInit = 0;
  $cell = new Cell(500, 300, 50, 50, 3.0); //main character. if additional character in future, change the arguments for different stats
  $tileMap = new TileMap("tile");
  $objMap = new TileMap("object");
  $mode = "reset";
  for (int i=0; i<4; i++) {
    $mov[i] = false;
    $dir[i] = false;
  }
  for (int i=0; i<2; i++) {
    $action[i] = false;
  }
  /**
  * temp
  */
  for (int i=0; i<3; i++) {
    $bg[i] = floor(random(256));
  }
}

/**
* main loop of game
*/
void draw() {
  if ($mode.equals("reset")) { //start at title screen
    image($images.getTitle(),0,0);
    if ($action[0]) {
      $mode = "play";
    }
  }
  else if ($mode.equals("play")) { //start the game
    background($bg[0], $bg[1], $bg[2]);
    $tileMap.updateBG();
    $objMap.updateBG();
    $cell.updateXY(xVal(),yVal());
    $cell.updateSprite();
  }
  else if ($mode == "scroll" && millis()/40 % 2 != $lim) {
    $lim = millis()/40 % 2;
    $cell.scroll();
    background($bg[0], $bg[1], $bg[2]);
    $tileMap.scroll();
    $objMap.scroll();
    $cell.updateSprite();
    $frame++;
  }
  if (!$mode.equals("reset")) { //things to handle when the game isnt on the title screen
    if ($action[1]) {
      reset();
    }
    image($images.getBanner(),0,0);
  }
}

/**
* handles key inputs
*/
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      $dir[0] = true;
    }
    if (keyCode == LEFT) {
      $dir[1] = true;
    }
    if (keyCode == DOWN) {
      $dir[2] = true;
    }
    if (keyCode == RIGHT) {
      $dir[3] = true;
    }
  }
  else {
    Character k = key;
    k = k.toLowerCase(k);
    if (k == 'w') {
      $mov[0] = true;
      $yPriority = 1;
    }
    if (k == 'a') {
      $mov[1] = true;
      $xPriority = -1;
    }
    if (k == 's') {
      $mov[2] = true;
      $yPriority = -1;
    }
    if (k == 'd') {
      $mov[3] = true;
      $xPriority = 1;
    }
    if (key == ' ') {
      $action[0] = true;
    }
    if (key == '\\') {
      $action[1] = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      $dir[0] = false;
    }
    if (keyCode == LEFT) {
      $dir[1] = false;
    }
    if (keyCode == DOWN) {
      $dir[2] = false;
    }
    if (keyCode == RIGHT) {
      $dir[3] = false;
    }
  }
  else {
    Character k = key;
    k = k.toLowerCase(k);
    if (k == 'w') {
      $mov[0] = false;
    }
    if (k == 'a') {
      $mov[1] = false;
    }
    if (k == 's') {
      $mov[2] = false;
    }
    if (k == 'd') {
      $mov[3] = false;
    }
    if (key == ' ') {
      $action[0] = false;
    }
    if (key == '\\') {
      $action[1] = false;
    }
  }
}

  /**
  * returns direction to move in, in instance of conflicting keys
  */
  int xVal() {
    if ($mov[1] && $mov[3]) {
      return $xPriority;
    }
    return $mov[1]? -1:($mov[3]? 1:0);
  }
  int yVal() {
    if ($mov[0] && $mov[2]) {
      return $yPriority;
    }
    return $mov[0]? -1:($mov[2]? 1:0);
  }
