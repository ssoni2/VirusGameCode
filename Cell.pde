/**
* class for the white blood cell
*/
class Cell {
  ArrayList<ArrayList<PImage>> _sprites; //sprites for the cell
  int _index; //sprite index
  int _width, _height; //width and height
  float _x, _y; //x and y position
  float _speed; //current speed
  float _maxSpeed; //maximum speed
  float _accel; //acceleration
  Boolean _moving = false; //checks if cell is idle or moving
  
  Cell(int x, int y, int w, int h, float speed) {
    _index = 0;
    _width = w;
    _height = h;
    _x = x;
    _y = y;
    _speed = 0;
    _maxSpeed = speed;
    _accel = 0.1;
    _sprites = $images.getCellSprites();
  }
  
  void updateSprite() {
    image(_sprites.get(_index).get(animate(_index)),_x,_y,_width,_height);
  }
  
  int animate(int sprite) {
    if (_moving) {
      return (millis()/245 % _sprites.get(sprite).size());
    }
    return 0; //don't animate--idle
  }
  

  
  /**
  * move the cell. account for if a move is legal as well
  */
  void updateXY(int xDir, int yDir) {
    if (xDir == 0 && yDir == 0) {
      _moving = false;
      _speed = 0;
    }
    else {
      if (_speed < _maxSpeed) {
        _speed += _accel;
      }
      if (_speed > _maxSpeed) {
        _speed = _maxSpeed;
      }
      _moving = true;
    }
    float nextX = _x + xDir*_speed, nextY = _y + yDir*_speed;
    if (yDir != 0) {
      nextX = _x + xDir*sqrt(sq(_speed)/2);
    }
    if (xDir != 0) {
      nextY = _y + yDir*sqrt(sq(_speed)/2);
    }
    Tile[][] tBoundsX = $tileMap.getBounds(nextX,_y,_width,_height);
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        if (tBoundsX[i][j].isBlock()) {
          nextX = _x;
        }
      }
    }
    Tile[][] tBoundsY = $tileMap.getBounds(nextX,nextY,_width,_height);
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        if (tBoundsY[i][j].isBlock()) {
          nextY = _y;
        }
      }
    }
    if (nextX < 216) {
      $colMap--;
      $mode = "scroll";
    }
    else if (nextX+_width-1 >= width) {
      $colMap++;
      $mode = "scroll";
    }
    else if (nextY < 0) {
      $rowMap--;
      $mode = "scroll";
    }
    else if (nextY+_height-1 >= $rows*$tSize) {
      $rowMap++;
      $mode = "scroll";
    }
    _x = nextX;
    _y = nextY;
  }
  
  /**
  * scroll the cell with the maps
  */
  void scroll() {
    int deltaX = $colMap - $colMapInit;
    int deltaY = $rowMap - $rowMapInit;
    if ($frame == 0) {
      _x += deltaX*$tSize;
      _y += deltaY*$tSize;
    }
    _x -= deltaX*$tSize;
    _y -= deltaY*$tSize;
  }
}
