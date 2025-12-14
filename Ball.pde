class Ball {
  
  PVector location = new PVector(0, 0);
  PVector speed = new PVector(0, 0);
  float diameter;
  color c;
  
  // Constructor method
  Ball(float tempX, float tempY, float tempDiameter) {
    location.x = tempX;
    location.y = tempY;
    diameter = tempDiameter;
    speed.x = 0;
    speed.y = 0;
    c = (225); 
  }
  
  void move() {
    // Add speed to location
    location.y = location.y + speed.y;
    location.x = location.x + speed.x;
  }
  
  void display() {
    fill(c); //set the drawing color
    ellipse(location.x,location.y,diameter,diameter); //draw a circle
  }
  
  //functions to help with collision detection
  float left(){
    return location.x-diameter/2;
  }
  float right(){
    return location.x+diameter/2;
  }
  float top(){
    return location.y-diameter/2;
  }
  float bottom(){
    return location.y+diameter/2;
  }

}
