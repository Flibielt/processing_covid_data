long getDaysBetween(LocalDate dateBefore, LocalDate dateAfter) {
  return ChronoUnit.DAYS.between(dateBefore, dateAfter);
}

void checkClickOnMap() {
  for (String code : countries.keySet()) {
    Country country = countries.get(code);

    if (country.isMouseOver()) {
      if (selectedCountries.contains(country.getAlphaCode3())) {
        selectedCountries.remove(country.getAlphaCode3());
        dataVisualization.removeCountry(country.getAlphaCode3());
      } else {
        selectedCountries.add(country.getAlphaCode3());
        dataVisualization.addCountry(country.getAlphaCode3());
      }
    }
  }
}

void drawTitleTabs() {
  rectMode(CORNERS);
  //noStroke();
  textSize(20);
  textAlign(LEFT);

  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs
  if (tabLeft == null) {
    tabLeft = new float[dataTypes.length];
    tabRight = new float[dataTypes.length];
  }
  
  float runningX = plotX1; 
  tabTop = plotY1 - textAscent() - 15;
  tabBottom = plotY1;
  
  for (int col = 0; col < dataTypes.length; col++) {
    String title = dataTypes[col].toString();
    tabLeft[col] = runningX; 
    float titleWidth = textWidth(title);
    tabRight[col] = tabLeft[col] + tabPad + titleWidth + tabPad;
    
    // If the current tab, set its background white, otherwise use pale gray
    fill(col == currentColumn ? 255 : 224);
    rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
    
    // If the current tab, use black for the text, otherwise use dark gray
    fill(col == currentColumn ? 0 : 64);
    text(title, runningX + tabPad, plotY1 - 10);
    
    runningX = tabRight[col];
  }
}