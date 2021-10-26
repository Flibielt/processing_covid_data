PShape map, hungary;
int svgX, svgY;

void setup() {
  size(1024, 800);
  svgX = 280;
  svgY = 40;
  
  map = loadShape("countries_of_europe.svg");
  map.disableStyle();
  
  hungary = map.getChild("hu");
  background(255);
}

void draw() {
  fill(255);
  shape(map, svgX, svgY);
  
  if (hungary.contains((mouseX - svgX), (mouseY - svgY))) {
    fill(200);
    shape(hungary, svgX, svgY);
    fill(0);
    text("Hungary", mouseX, mouseY);
  }
}
