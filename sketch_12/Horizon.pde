class Horizon {
  float yPos;
  int density;
  int bandOpacity;
  
  Horizon() {
    yPos = height;
    density = 4;
    bandOpacity = 10;
  }
  
  Horizon(float p_y) {
    yPos = p_y;
    density = 4;
    bandOpacity = 10;
  }
  
  Horizon(float p_y, int p_d, int p_o) {
    yPos = p_y;
    density = p_d;
    bandOpacity = p_o;
  }
  
  void display(int i) {
    // Set fill for FFT bands
    fill(colorHandler.bandColor, bandOpacity);
    
    if(i%density == 0) {
      rect(0, yPos, width, -spectrum[i]*height*fftMultiplier);
    }
  }
}
