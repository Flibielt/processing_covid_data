int maxDataForDate = 0;

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

  colorMode(HSB);

  for (CovidData covidData : covidDataForDate) {
    float saturation = 0;
    int data = 0;
    String countryCode;

    if (dataType == DataType.CASE_COUNT) {
      data = covidData.getCaseCount();
    } else if (dataType == DataType.DEATH_COUNT) {
      data = covidData.getDeathCount();
    } else if (dataType == DataType.TEST_COUNT) {
      data = covidData.getTestCount();
    }

    saturation = map(data, 0, maxDataForDate, 25, 100);
    if (alpha3Alpha2.containsKey(covidData.getCountryCode())) {
      countryCode = alpha3Alpha2.get(covidData.getCountryCode());
      println(saturation);
      Country country = countries.get(countryCode);
      fill(0, saturation, 100);
      shape(country.getShape(), svgX, svgY);
    }
  }

  colorMode(RGB);
}