int maxDataForDate = 0;
color endColor = color(255, 0, 0);
color startColor = color(255);

void displaytopCountries() {
  List<CovidData> topCountries = new ArrayList();
  int limit = 7;

  textAlign(LEFT);
  textSize(30);
  text("TOP 7", svgX, svgY + map.height + 90);

  if (dataType == DataType.CASE_COUNT) {
    topCountries = covidDataForDate.stream()
      .sorted((c1, c2) -> -c1.getCaseCount().compareTo(c2.getCaseCount()))
      .limit(limit)
      .collect(Collectors.toList());
  } else if (dataType == DataType.DEATH_COUNT) {
    topCountries = covidDataForDate.stream()
      .sorted((c1, c2) -> -c1.getDeathCount().compareTo(c2.getDeathCount()))
      .limit(limit)
      .collect(Collectors.toList());
  } else if (dataType == DataType.TEST_COUNT) {
    topCountries = covidDataForDate.stream()
      .sorted((c1, c2) -> -c1.getTestCount().compareTo(c2.getTestCount()))
      .limit(limit)
      .collect(Collectors.toList());
  }

  if (dataType == DataType.CASE_COUNT && topCountries.size() > 1) {
    maxDataForDate = topCountries.get(0).getCaseCount();
  } else if (dataType == DataType.DEATH_COUNT && topCountries.size() > 1) {
    maxDataForDate = topCountries.get(0).getDeathCount();
  } else if (dataType == DataType.TEST_COUNT && topCountries.size() > 1) {
    maxDataForDate = topCountries.get(0).getTestCount();
  }
  
  for (int i = 0; i < topCountries.size(); i++) {
    String coivdDataText = "";

    CovidData covidData = topCountries.get(i);
    if (dataType == DataType.CASE_COUNT) {
      coivdDataText = covidData.getCountryName() + ": " + covidData.getCaseCount();
    } else if (dataType == DataType.DEATH_COUNT) {
      coivdDataText = covidData.getCountryName() + ": " + covidData.getDeathCount();
    } else if (dataType == DataType.TEST_COUNT) {
      coivdDataText = covidData.getCountryName() + ": " + covidData.getTestCount();
    }

    text(coivdDataText, svgX, svgY + map.height + 90 + (i + 1) * 40);
  }
}

void drawCountryHeatMap() {
  if (covidDataForDate.size() < 1) {
    return;
  }

  for (CovidData covidData : covidDataForDate) {
    float percentage = 0;
    int data = 0;
    String countryCode;

    if (dataType == DataType.CASE_COUNT) {
      data = covidData.getCaseCount();
    } else if (dataType == DataType.DEATH_COUNT) {
      data = covidData.getDeathCount();
    } else if (dataType == DataType.TEST_COUNT) {
      data = covidData.getTestCount();
    }

    percentage = map(data, 0, globalDataMax, 0, 100);
    percentage = percentage / 100; 
    color c = lerpColor(startColor, endColor, percentage);
    if (alpha3Alpha2.containsKey(covidData.getCountryCode())) {
      countryCode = alpha3Alpha2.get(covidData.getCountryCode());
      Country country = countries.get(countryCode);
      fill(c);
      shape(country.getShape(), svgX, svgY);
    }
  }

  colorMode(RGB);
}