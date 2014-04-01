/**
* class to load and get game images
*/
class Images {
  PImage _title; //title screen background image
  PImage _banner; //left side banner for UI
  ArrayList<ArrayList<PImage>> _cells; //white blood cell sprites
  ArrayList<ArrayList<PImage>> _tiles;
  ArrayList<ArrayList<PImage>> _objects;
  
  Images() {
    _title = loadImage("images/title.png");
    _banner = loadImage("images/banner.png");
    
    _cells = new ArrayList<ArrayList<PImage>>();
    String fileName = "images/sprite0a.png";
    File file = new File(dataPath(fileName));
    int i = 0;
    char c = 'a';
    while(file.exists()) {
      _cells.add(new ArrayList<PImage>());
      while (file.exists()) {
        _cells.get(i).add(loadImage(fileName));
        c++;
        fileName = "images/sprite"+i+c+".png";
        file = new File(dataPath(fileName));
      }
      c = 'a';
      i++;
      fileName = "images/sprite"+i+c+".png";
      file = new File(dataPath(fileName));
    }
    
    _tiles = new ArrayList<ArrayList<PImage>>();
    fileName = "images/tile0a.png";
    file = new File(dataPath(fileName));
    i = 0;
    c = 'a';
    while(file.exists()) {
      _tiles.add(new ArrayList<PImage>());
      while (file.exists()) {
        _tiles.get(i).add(loadImage(fileName));
        c++;
        fileName = "images/tile"+i+c+".png";
        file = new File(dataPath(fileName));
      }
      c = 'a';
      i++;
      fileName = "images/tile"+i+c+".png";
      file = new File(dataPath(fileName));
    }
    
    _objects = new ArrayList<ArrayList<PImage>>();
    fileName = "images/object0a.png";
    file = new File(dataPath(fileName));
    i = 0;
    c = 'a';
    while(file.exists()) {
      _objects.add(new ArrayList<PImage>());
      while (file.exists()) {
        _objects.get(i).add(loadImage(fileName));
        c++;
        fileName = "images/object"+i+c+".png";
        file = new File(dataPath(fileName));
      }
      c = 'a';
      i++;
      fileName = "images/object"+i+c+".png";
      file = new File(dataPath(fileName));
    }
  }
  
  PImage getTitle() {
    return _title;
  }
  PImage getBanner() {
    return _banner;
  }
  
  ArrayList<ArrayList<PImage>> getCellSprites() {
    return _cells;
  }
  
  ArrayList<PImage> getSprites(String type, char index) {
    int i;
    if (index >= 'A') {
      i = index - 65;
    }
    else {
      i = index - 48;
    }
    if (type =="tile") {
      return _tiles.get(i);
    }
    return _objects.get(i);
  }
}
