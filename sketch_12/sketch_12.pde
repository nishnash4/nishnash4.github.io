// Declaring global visible objects
UI userInterface;
ColorHandler colorHandler;
AmpBorder border;
Pulse pulse1;
Pulse pulse2;
Pulse pulse3;
AmpCircle ampCircle1;
AmpCircle ampCircle2;
AmpCircle ampCircle3;
Star star1;
Pulse horizonP;


// Processing Sound library
import processing.sound.*;
Sound s;
AudioIn audioIn;
Amplitude amp;
FFT fft;
int bands = 1024;
float fftMultiplier = 10;
float[] spectrum = new float[bands];

int bgRefreshRate = 150;

// Keyboard controls
char keySwitch;
float value = 1;
float multiplier = 1;
boolean tensToggle;
int negativeToggle = 1;
float divider = 1;

void setup() {
  // Initial window settings
  size(960, 960);
  frameRate(60);
  noStroke();
  rectMode(CORNER);
  surface.setTitle("zak's music visualizer");
  
  // PROCESSING SOUND
  s = new Sound(this);
  // List devices
  Sound.list();
  // Mac input
  //s.inputDevice(3);
  // Windows input (Voicemeeter Output)
  s.inputDevice(7);
  // Set up audio in stream
  audioIn = new AudioIn(this, 0);
  audioIn.start();
  // Initialize amplitude object
  amp = new Amplitude(this);
  amp.input(audioIn);
  // Initialize FFT object
  fft = new FFT(this, bands);
  fft.input(audioIn);
  
  // Initialize color handler
  colorHandler = new ColorHandler();
  colorHandler.setNewColorPalette();
  
  // Initialize visible objects
  userInterface = new UI();
  border = new AmpBorder();
  
  // Triangle inwards
  pulse1 = new Pulse(140, 275, 450, 515);
  pulse2 = new Pulse(450, 515, 420, 170);
  pulse3 = new Pulse(420, 170, 140, 275);
  
  // AmpCircles
  ampCircle1 = new AmpCircle(190, 620, 0, 1800);
  ampCircle2 = new AmpCircle(770, 240, 3, 600);
  ampCircle3 = new AmpCircle(560, 810, 5, 1075);
  
  star1 = new Star(770, 620);
  
  horizonP = new Pulse(width, 850, 0, 850);
}

void draw() {
  colorHandler.refreshBackground(bgRefreshRate);

  // Analyze the FFT data
  fft.analyze(spectrum);
  
  
  for(int i = 0; i < bands; i++) {
    pulse1.display(i);
    pulse2.display(i);
    pulse3.display(i);
    
    star1.display(i);
    
    horizonP.display(i);
    
  }
  
  ampCircle1.display();
  ampCircle2.display();
  ampCircle3.display();
  
  
  
  
  
  
  border.display();
  
  // Trigger new color palette every once in a while
  for(int i = 0; i < 5; i++) {
    if(spectrum[(width/5)-i]*height*fftMultiplier > height/4) {
      //println("Triggered by spectrum value: " + spectrum[(width/5)-i]*height*fftMultiplier);
      colorHandler.setNewColorPalette();
    }
  }
  
  if(userInterface.toggled) {
    userInterface.updateText();
    userInterface.display();
  }
}

void mousePressed() {
  // If UI is toggled:
  if(userInterface.toggled) {
    int menuOptionSelector;
    
    // If mouse is clicked within UI box
    if(
      mouseX >= userInterface.xPos &&
      mouseX <= userInterface.xPos+userInterface.iWidth &&
      mouseY >= userInterface.yPos &&
      mouseY <= userInterface.yPos+userInterface.iHeight
    ) {
      println("Clicked within box");
    }
    
    menuOptionSelector = 12;
    if(
      mouseX >= userInterface.xPos+20 &&
      mouseX <= userInterface.xPos+(20+textWidth(userInterface.uiMenuText[menuOptionSelector])) &&
      mouseY >= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)-userInterface.textHeight &&
      mouseY <= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)
    ) {
      keySwitch = 'B';
      value = bgRefreshRate;
      println("Background refresh rate selected.");
    }
    
    menuOptionSelector = 14;
    if(
      mouseX >= userInterface.xPos+20 &&
      mouseX <= userInterface.xPos+(20+textWidth(userInterface.uiMenuText[menuOptionSelector])) &&
      mouseY >= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)-userInterface.textHeight &&
      mouseY <= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)
    ) {
      keySwitch = 'C';
      value = fftMultiplier;
      println("Scale of FFT spectrum selected.");
    }
    
    menuOptionSelector = 16;
    if(
      mouseX >= userInterface.xPos+20 &&
      mouseX <= userInterface.xPos+(20+textWidth(userInterface.uiMenuText[menuOptionSelector])) &&
      mouseY >= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)-userInterface.textHeight &&
      mouseY <= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)
    ) {
      keySwitch = 'Y';
      value = colorHandler.selection;
      println("Color palette change selected");
    }
    
    menuOptionSelector = 25;
    if(
      mouseX >= userInterface.xPos+20 &&
      mouseX <= userInterface.xPos+(20+textWidth(userInterface.uiMenuText[menuOptionSelector])) &&
      mouseY >= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)-userInterface.textHeight &&
      mouseY <= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)
    ) {
      if(multiplier == 10) {
        multiplier = 1;
        println("Multiplier disabled");
      } else {
        multiplier = 10;
        println("Multiplier enabled");
      }
      println("Multiplier selected");
    }
    
    menuOptionSelector = 27;
    if(
      mouseX >= userInterface.xPos+20 &&
      mouseX <= userInterface.xPos+(20+textWidth(userInterface.uiMenuText[menuOptionSelector])) &&
      mouseY >= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)-userInterface.textHeight &&
      mouseY <= userInterface.yPos+(userInterface.textHeight*menuOptionSelector+userInterface.textHeight*2)
    ) {
      if(divider == 10) {
        divider = 1;
        println("Divider disabled");
      } else {
        divider = 10;
        println("Divider enabled");
      }
      println("Divider selected");
    }
  }
}

void keyPressed() {
  if(key == '*') {
    if(multiplier == 10) {
      multiplier = 1;
      println("Multiplier disabled");
    } else {
      multiplier = 10;
      println("Multiplier enabled");
    }
  }
  
  if(key == '-') {
    if(negativeToggle == 1) {
      negativeToggle = -1;
      value = -value;
      println("Polarity switched");
    } else {
      negativeToggle = 1;
      value = -value;
      println("Polarity switched");
    }
  }
  
  if(key == '/') {
    if(divider == 10) {
      divider = 1;
      println("Divider disabled");
    } else {
      divider = 10;
      println("Divider enabled");
    }
  }
  
  if(key == 'b' || key == 'B') {
    keySwitch = 'B';
    value = bgRefreshRate;
    println("Background refresh rate selected.");
  }
  
  if(key == 'c' || key == 'C') {
    keySwitch = 'C';
    value = fftMultiplier;
    println("Scale of FFT spectrum selected.");
  }
  
  if(key == 'i' || key == 'I') {
    userInterface.toggle();
  }
  
  if(key == 's' || key == 'S') {
    String[] metadata = new String[7];
    metadata[0] = "Date: " + String.valueOf(month()) + "/" + String.valueOf(day()) + "/" + String.valueOf(year());
    metadata[1] = "Time: " + String.valueOf(hour()) + ":" + String.valueOf(minute()) + ":" + String.valueOf(second());
    metadata[2] = "";
    metadata[3] = "Canvas size: (" + width + ", " + height + ")";
    metadata[4] = "Number of bands: " + bands;
    metadata[5] = "Background refresh rate: " + bgRefreshRate;
    metadata[6] = "FFT Multiplier: " + fftMultiplier;
    saveStrings("gen2020_" + frameCount + ".txt", metadata);
    saveFrame("gen2020_####.png");
    println("Saved a frame and metadata");
  }
  
  if(key == 'x' || key == 'X') {
    colorHandler.forced = true;
    println("Forcing a color change");
    colorHandler.setNewColorPalette();
    colorHandler.forced = false;
  }
  
  if(key == 'y' || key == 'Y') {
    keySwitch = 'Y';
    value = colorHandler.selection;
    println("Color palette change selected");
  }
  
  if(key == '0') {
    calculateValue(0);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '1') {
    calculateValue(1);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '2') {
    calculateValue(2);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '3') {
    calculateValue(3);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '4') {
    calculateValue(4);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '5') {
    calculateValue(5);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '6') {
    calculateValue(6);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '7') {
    calculateValue(7);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '8') {
    calculateValue(8);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == '9') {
    calculateValue(9);
    switch(keySwitch) {
      case 'B':
        setBgRefreshRate();
        break;
      case 'C':
        setFFTMultiplier();
        break;
      case 'Y':
        colorHandler.setNewColorPalette();
        break;
    }
  }
  
  if(key == CODED) {
    if(keyCode == UP) {
      calculateValue(10);
      switch(keySwitch) {
        case 'B':
          setBgRefreshRate();
          break;
        case 'C':
          setFFTMultiplier();
          break;
        case 'Y':
          colorHandler.setNewColorPalette();
          break;
      }
    } else if(keyCode == DOWN) {
      calculateValue(11);
      switch(keySwitch) {
        case 'B':
          setBgRefreshRate();
          break;
        case 'C':
          setFFTMultiplier();
          break;
        case 'Y':
          colorHandler.setNewColorPalette();
          break;
      }
    }
  }
}

void calculateValue(float inputNumber) {
  if(inputNumber == 10) {
    value = value + (multiplier/divider);
  } else if(inputNumber == 11) {
    value = value - (multiplier/divider);
  } else {
    value = inputNumber*multiplier/divider;
  }
  
  println("Value set to: " + value);
}

void setBgRefreshRate() {
  // No negative numbers
  // Must be an int
  // Must be between 0 and 255
  
  if(value > 255) {
    bgRefreshRate = 255;
    println("Background refresh rate maximum reached.");
  } else if(value < 0) {
    bgRefreshRate = 0;
    println("Background refresh rate minimum reached.");
  } else {
    bgRefreshRate = abs(int(value));
  }
  
  println("Background refresh rate set to: " + bgRefreshRate);
}

void setFFTMultiplier() {
  // No negative numbers
  
  fftMultiplier = abs(value);
  
  println("FFT Multiplier set to: " + fftMultiplier);
}
