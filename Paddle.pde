class Paddle {

  PVector location = new PVector(0, 0);
  PVector speed = new PVector(0, 0);
  float w;
  float h;
  color c;

  Paddle(float tempX, float tempY, float tempW, float tempH) {
    location.x= tempX;
    location.y= tempY;
    w = tempW;
    h = tempH;
    speed.y = 0;
    speed.x = 0;
    c=(255);
  }

  void move() {
    location.y+= speed.y;
    location.x+= speed.x;
  }

  void display() {
    fill(c);
    noStroke();
    rect(location.x-w/2, location.y-h/2, w, h, 10);
  }

  //helper functions
  float left() {
    return location.x-w/2;
  }
  float right() {
    return location.x+w/2;
  }
  float top() {
    return location.y-h/2;
  }
  float bottom() {
    return location.y+h/2;
  }
}
