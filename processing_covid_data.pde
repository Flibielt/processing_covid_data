PShape map, hungary;
int svgX, svgY;
HashMap<String, Country> countries;

void setup() {
  size(1024, 800);
  svgX = 280;
  svgY = 40;
  
  map = loadShape("countries_of_europe.svg");
  map.disableStyle();
  
  hungary = map.getChild("hu");
  background(255);
  
  loadCountries();
}

void loadCountries() {
  Table countryCodes;
  countryCodes = loadTable("countries_codes_and_coordinates.tsv", "header, tsv");
  countries = new HashMap();

  for (TableRow row : countryCodes.rows()) {
    String code = row.getString("Alpha-2_code");
      PShape shape = map.getChild(code.toLowerCase());
      if (shape != null) {
        Country country = new Country(row.getString("Country"), code, row.getString("Alpha-3_code"), shape);
        
        countries.put(code, country);
      }
  }
}

void draw() {
  background(255);
  fill(255);
  shape(map, svgX, svgY);
  
  for (String code : countries.keySet()) {
    Country country = countries.get(code);

    if (country.isMouseOver()) {
      fill(200);
      shape(country.getShape(), svgX, svgY);
      fill(0);
      text(country.getName(), mouseX, mouseY);
    }
  }

}
