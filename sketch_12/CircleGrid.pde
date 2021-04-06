class CircleGrid {
  int numCircles;
  float minWidth;
  float maxWidth;
  
  // Default constructor
  CircleGrid() {
    numCircles = 7;
    minWidth = 5;
    maxWidth = 200;
  }
  
  // Just number of circles
  CircleGrid(int p_num) {
    numCircles = p_num;
    minWidth = 5;
    maxWidth = 200;
  }
  
  // Number of circles, min & max width
  CircleGrid(int p_num, float p_min, float p_max) {
    numCircles = p_num;
    minWidth = p_min;
    maxWidth = p_max;
  }
  
  void display() {
    
    
    // Normally, amplitude is between 0 and 1, but is rarely close to 1
    float circleSize = map(amp.analyze(), 0, .5, minWidth, maxWidth);
    
    for(int y = 0; y < width; y++) {
      for(int x = 0; x < height; x++) {
        if(x%(height/numCircles) == 0 && y%(width/numCircles) == 0) {
          pushMatrix();
            translate(width/numCircles/2, height/numCircles/2);
            strokeWeight(circleSize/2);
            stroke(255);
            fill(colorHandler.circleColor);
            ellipse(x, y, circleSize, circleSize);
            noStroke();
          popMatrix();
        }
      }
    }
  }
}
