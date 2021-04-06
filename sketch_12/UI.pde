class UI {
  boolean toggled;
  float xPos;
  float yPos;
  float iWidth;
  float iHeight;
  int textHeight;
  String[] uiMenuText;

  // Default constructor
  UI() {
    toggled = false;

    textHeight = 16;
    textSize(textHeight);

    uiMenuText = new String[28];
    updateText();

    iHeight = (uiMenuText.length+2)*textHeight;
    iWidth = textWidth(uiMenuText[12]) + 40;

    xPos = width-iWidth-20;
    yPos = 20;
  }

  void toggle() {
    toggled = !toggled;

    if (toggled) {
      println();
      println();
      println();
      println("=================");
      println("AVAILABLE INPUTS:");
      println("=================");
      println("   * - Toggle multiplier");
      println("   / - Toggle divider");
      println("   - - Toggle value polarity");
      println(" 0-9 - Set value, based on multiplier and divider");
      println("   B - Enable background refresh rate mode");
      println("   C - Enable FFT spectrum scale mode");
      println("   I - Toggle user interface");
      println("   S - Save a frame of the screen along with a metadata file");
      println("   X - Immediately force change the color palette");
      println("   Y - Enable color palette selection mode");
      println("  UP - Increase value by 1, based on multiplier and divider");
      println("DOWN - Decrease value by 1, based on multipler and divider");
    } else {
      noStroke();
      fill(colorHandler.bgColor);
      rect(0, 0, width, height);
      println("UI toggled off");
    }
  }

  void display() {
    // Move main UI display to relative (xPos, yPos)
    pushMatrix();
      translate(xPos, yPos);
  
      // Draw background
      strokeWeight(2);
      stroke(0);
      fill(255);
      rect(0, 0, iWidth, iHeight);
  
      // Set text styling
      noStroke();
      fill(0);
      textSize(textHeight);
  
      // Draw text
      for (int i = 0; i < uiMenuText.length; i++) {
        // Set null strings to empty strings
        if (uiMenuText[i] == null) {
          uiMenuText[i] = "";
        }
  
        // Insert text line by line from uiMenuText string array
        text(uiMenuText[i], 20, textHeight*i+textHeight*2);
      }
  
      noStroke();
      fill(colorHandler.bgColor);
      fill(0);
    popMatrix();

    // Visual indication of when to draw new color palette
    fill(255);
    stroke(255);
    strokeWeight(1);
    rect(width/5, 0, 5, height);
    line(0, height/4*3, width, height/4*3);
    noStroke();

    pushMatrix();
      translate(20, 20);
  
      // Draw box background
      strokeWeight(2);
      stroke(0);
      fill(255);
      rect(0, 0, iWidth, (colorHandler.numberOfOptions/2)*(iWidth/2-10)+20 );
  
      for (int i = 0; i < colorHandler.numberOfOptions; i++) {
        drawPalette(i);
      }
    popMatrix();
    
    drawCursorLoc();
  }

  void updateText() {
    uiMenuText[0] = "zak's music visualizer";
    uiMenuText[3] = "METADATA";
    uiMenuText[5] = "canvas size: (" + width + ", " + height + ")";
    uiMenuText[7] = "number of bands: " + bands;
    uiMenuText[10] = "EDITABLE";
    uiMenuText[12] = "background refresh rate [b]: " + bgRefreshRate;
    uiMenuText[14] = "fft multiplier [c]: " + fftMultiplier;
    uiMenuText[16] = "color palette [y]: " + colorHandler.selection;
    uiMenuText[19] = "VALUE MODIFIERS";
    uiMenuText[21] = "current keyBind: " + keySwitch;
    uiMenuText[23] = "current raw value: " + value;
    if (multiplier == 10) {
      uiMenuText[25] = "multiplier [*]: enabled";
    } else {
      uiMenuText[25] = "multiplier [*]: disabled";
    }
    if (divider == 10) {
      uiMenuText[27] = "divider [/]: enabled";
    } else {
      uiMenuText[27] = "divider [/]: disabled";
    }
  }

  void drawPalette(int paletteNum) {
    pushMatrix();
      translate(20, 20);
      stroke(0);
      strokeWeight(1);
      fill(colorHandler.palette[paletteNum].bgColor);
      rect(((paletteNum%2)*(iWidth/2-10)), ((paletteNum%colorHandler.numberOfOptions/2)*(iWidth/2-10)), (iWidth/2-30)/2, iWidth/2-30);
      fill(colorHandler.palette[paletteNum].bandColor);
      rect(((iWidth/2-30)/2)+( (paletteNum%2)*(iWidth/2-10) ), (0)+( (paletteNum%colorHandler.numberOfOptions/2)*(iWidth/2-10) ), (iWidth/2-30)/2, (iWidth/2-30)/2);
      fill(colorHandler.palette[paletteNum].circleColor);
      rect(((iWidth/2-30)/2)+( (paletteNum%2)*(iWidth/2-10) ), ((iWidth/2-30)/2)+( (paletteNum%colorHandler.numberOfOptions/2)*(iWidth/2-10) ), (iWidth/2-30)/2, (iWidth/2-30)/2);
      fill(255);
      ellipse(((iWidth/2-30)/2)+( (paletteNum%2)*(iWidth/2-10) ), ((iWidth/2-30)/2)+( (paletteNum%colorHandler.numberOfOptions/2)*(iWidth/2-10) ), 30, 30);
      fill(0);
      text(paletteNum, ((iWidth/2-30)/2)+( (paletteNum%2)*(iWidth/2-10)-(textWidth(str(paletteNum)))/2 ), (((iWidth/2-30)/2)+((paletteNum%colorHandler.numberOfOptions/2)*(iWidth/2-10)))+textHeight/2);
    popMatrix();
  }
  
  void drawCursorLoc() {
    String mouseLoc = "(" + mouseX + ", " + mouseY + ")";
    
    // Draw box background
    strokeWeight(2);
    stroke(0);
    fill(255);
    int padding = 6;
    rect(mouseX-textWidth(mouseLoc)/2-padding, mouseY-textHeight/2+padding, textWidth(mouseLoc)+padding*2, -textHeight-padding*2);
    ellipse(mouseX, mouseY, 2, 2);
    
    // Set text styling
    noStroke();
    fill(0);
    textSize(textHeight);
    
    text(mouseLoc, mouseX-textWidth(mouseLoc)/2, mouseY-textHeight/2);
  }
}
