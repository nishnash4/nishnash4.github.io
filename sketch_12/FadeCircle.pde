class FadeCircle {
  float xPos;
  float yPos;
  float size;
  
  FadeCircle() {
    xPos = width/2;
    yPos = height/2;
    size = 300;
  }
  
  void display() {
    noStroke();
    fill(colorHandler.circleColor, (size/2)/100);
    for(int i = 0; i < size/2; i++) {
      ellipse(xPos, yPos, i, i);
    }
  }
}
