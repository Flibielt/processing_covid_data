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
