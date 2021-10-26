PShape map;

void setup() {
  size(1024, 800);
  // The file "bot1.svg" must be in the data folder
  // of the current sketch to load successfully
  map = loadShape("countries_of_europe.svg");
}

void draw(){
  background(102);
  shape(map, 280, 40);
}
