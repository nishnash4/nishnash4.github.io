class ColorPalette {
  color bandColor;
  color circleColor;
  color bgColor;
  
  ColorPalette(color p_band, color p_circ, color p_bg) {
    bandColor = p_band;
    circleColor = p_circ;
    bgColor = color(red(p_bg), green(p_bg), blue(p_bg));
  }
}
