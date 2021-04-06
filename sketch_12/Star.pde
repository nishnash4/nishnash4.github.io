class Star {
  float xPos;
  float yPos;
  
  Star() {
    xPos = width/2;
    yPos = height/2;
  }
  
  Star(float p_x, float p_y) {
    xPos = p_x;
    yPos = p_y;
  }
  
  void display(int i) {
    fill(colorHandler.bandColor);
    
    pushMatrix();
      translate(xPos, yPos);
      rotate(PI/4);
      rotate(i*(radians(360)/float(bands)));
      for(int r = 0; r < 4; r++) {
        rect(0, 0, width/float(bands), -spectrum[i]*height*fftMultiplier);
        rotate(PI/2);
      }
    popMatrix();
    
    pushMatrix();
      translate(xPos, yPos);
      rotate(PI/4);
      rotate(-i*(radians(360)/float(bands)));
      for(int r = 0; r < 4; r++) {
        rect(0, 0, width/float(bands), -spectrum[i]*height*fftMultiplier);
        rotate(PI/2);
      }
    popMatrix();  
  } 
}
