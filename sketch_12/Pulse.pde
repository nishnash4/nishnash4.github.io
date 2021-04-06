class Pulse {
  float x1, x2, y1, y2;
  int density;
  int bandOpacity;
  
  Pulse() {
    x1 = 0;
    y1 = height/2;
    x2 = width;
    y2 = height/2;
    density = 4;
    bandOpacity = 10;
  }
  
  Pulse(float p_x1, float p_y1, float p_x2, float p_y2) {
    x1 = p_x1;
    y1 = p_y1;
    x2 = p_x2;
    y2 = p_y2;
    density = 4;
    bandOpacity = 10;
  }
  
  Pulse(float p_x1, float p_y1, float p_x2, float p_y2, int p_d, int p_o) {
    x1 = p_x1;
    y1 = p_y1;
    x2 = p_x2;
    y2 = p_y2;
    density = p_d;
    bandOpacity = p_o;
  }
  
  void display(int i) {
    // Set fill for FFT bands
    fill(colorHandler.bandColor, bandOpacity);
    pushMatrix();
      translate(x1, y1);
      rotate(atan2(y2-y1, x2-x1));
      //rotate(atan2(y2, x2));
      if(i%density == 0) {
        rect(0, 0, lineDistance(), -spectrum[i]*height*fftMultiplier);
      }
    popMatrix();
  }
  
  float lineDistance() {
    return (sqrt(sq(x2-x1)+sq(y2-y1)));
  }
}
