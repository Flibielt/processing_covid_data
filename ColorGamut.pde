void drawColorGamut(int x, int y, float w, float h) {
  noFill();

  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(startColor, endColor, inter);
    stroke(c);
    line(i, y, i, y+h);
  }

  noStroke();
  fill(color(0));
  textSize(20);
  text("0", x, y - 2);

  textAlign(RIGHT);
  text(globalDataMax, x + w, y - 2);
}