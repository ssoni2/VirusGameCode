/**
* class for each individual tile
*/
class Tile {
  String _type;
  char _index;
  float _tX, _tY;
  ArrayList<PImage> _frame;
  int _lim;
  
  Tile(String type, char index, float tX, float tY) {
    _type = type;
    _index = index;
    _tX = tX;
    _tY = tY;
    _frame = $images.getSprites(_type,_index);
  }

  char index() {
    return _index;
  }

  void paint(int x, int y) {
    int a = animate();
    image(_frame.get(a),x,y);
    noTint();
  }
  
  int animate() {
    return (millis()/150 % _frame.size());
  }
  
  Boolean isBlock() {
    if (_type == "tile") {
      return _index == '1';
    }
    return false;
  }
}
