class AmpCircle {
  float xPos;
  float yPos;
  float minDiameter;
  float maxDiameter;
  
  AmpCircle() {
    xPos = width/2;
    yPos = height/2;
    minDiameter = 5;
    maxDiameter = 875;
  }
  
  AmpCircle(float p_x, float p_y) {
    xPos = p_x;
    yPos = p_y;
    minDiameter = 5;
    maxDiameter = 875;
  }
  
  AmpCircle(float p_x, float p_y, float p_min, float p_max) {
    xPos = p_x;
    yPos = p_y;
    minDiameter = p_min;
    maxDiameter = p_max;
  }
  
  void display() {
    noStroke();
    fill(colorHandler.circleColor);
    ellipse(xPos, yPos, map(amp.analyze(), 0, .8, minDiameter, maxDiameter), map(amp.analyze(), 0, .8, minDiameter, maxDiameter));
  }
}
