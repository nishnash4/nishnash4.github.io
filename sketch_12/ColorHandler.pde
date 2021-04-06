class ColorHandler {
  color bandColor;
  color circleColor;
  color bgColor;
  
  int numberOfOptions;
  int selection;
  ColorPalette[] palette;
  int colorChangeCooldown;
  int lastColorChange;
  boolean forced;
  
  ColorHandler() {
    numberOfOptions = 8;
    selection = 0;
    palette = new ColorPalette[numberOfOptions];
    
    // Yellow bands, orange circle, blue bg
    palette[0] = new ColorPalette(color(#FFEB6C), color(#FCA456), color(41, 43, 145));
    // Yellow bands, cyan circle, dark cyan bg
    palette[1] = new ColorPalette(color(#FFFF61), color(#1BACB4), color(32, 122, 125));
    // Pale purple bands, red circle, purple bg
    palette[2] = new ColorPalette(color(#D0A0CB), color(#C3021F), color(74, 11, 99));
    // Orange bands, yellow circle, light blue bg
    palette[3] = new ColorPalette(color(#FF993A), color(#FEED35), color(92, 127, 187));
    // Light green bands, mint green circle, purple bg
    palette[4] = new ColorPalette(color(#B0FFB7), color(#05C36A), color(66, 18, 99));
    // Pink bands, dark purple circle, blue bg
    palette[5] = new ColorPalette(color(#FA958C), color(#422B7B), color(41, 80, 151));
    // Pink bands, dark brown circle, lime bg
    palette[6] = new ColorPalette(color(#DA7D6E), color(#3A2E3A), color(115, 186, 58));
    // Yellow bands, purple circle, green bg
    palette[7] = new ColorPalette(color(#FFAD40), color(#471D64), color(9, 77, 8));
  }
  
  void setNewColorPalette() {
    // Don't change color if color has changed within the last second
    // Based off of 60fps frameRate
    if(frameCount <= lastColorChange + 45 && frameCount != 0 && !forced) {
      /*
      println("Last color change: " + lastColorChange);
      println("Tried to change at frame: " + frameCount);
      println("Color change denied, within cooldown");
      */
    } else {      
      if(keySwitch == 'Y') {
        selection = abs(int(value))%numberOfOptions;
      } else {
        selection = frameCount%numberOfOptions;
      }
      
      selectPalette(selection);
      println("Setting to palette " + selection);
      
      // Set framecount marker
      lastColorChange = frameCount;
      println("Changed colors at frame: " + lastColorChange);
    } 
  }
  
  void selectPalette(int in) {
    bandColor = palette[in].bandColor;
    circleColor = palette[in].circleColor;
    bgColor = palette[in].bgColor;
  }
  
  void refreshBackground(int bgRefreshRate) {
    // Clear background
    noStroke();
    fill(color(colorHandler.bgColor, bgRefreshRate));
    rect(0, 0, width, height);
  }
}
