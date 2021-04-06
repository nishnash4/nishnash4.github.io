class AmpBorder {
  float minSize;
  float maxSize;
  
  AmpBorder() {
    minSize = 0;
    maxSize = 200;
  }
  
  AmpBorder(float p_min, float p_max) {
    minSize = p_min;
    maxSize = p_max;
  }
  
  void display() {
    noStroke();
    fill(colorHandler.circleColor);
    // Top
    rect(0, 0, width, map(amp.analyze(), 0, 1, minSize, maxSize));
    // Bottom
    rect(0, height, width, -map(amp.analyze(), 0, 1, minSize, maxSize));
    // Left
    rect(0, 0, map(amp.analyze(), 0, 1, minSize, maxSize), height);
    // Right
    rect(width, 0, -map(amp.analyze(), 0, 1, minSize, maxSize), height);
  }
}
