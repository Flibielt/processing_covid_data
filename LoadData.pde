void loadCovidData() {
  Table covidDataTable = loadTable("owid-covid-data-europe.csv", "header");
  countryCovidData = new HashMap();

  try {

    for (TableRow row : covidDataTable.rows()) {
      String countryCode = row.getString("iso_code");

      if (!countryCovidData.containsKey(countryCode)) {
        List<CovidData> covidDatas = new ArrayList();
        countryCovidData.put(countryCode, covidDatas);
      }

      CovidData covidData = new CovidData();
      LocalDate date = LocalDate.parse(row.getString("date"), formatter);

      if (date.isAfter(globalMaxDate)) {
        globalMaxDate = date;
      } else if (date.isBefore(globalMinDate)) {
        globalMinDate = date;
      }

      covidData.setCountryName(row.getString("location"));
      covidData.setCountryCode(row.getString("iso_code"));
      covidData.setDate(date);
      covidData.setTotalCaseCount(row.getInt("total_cases"));
      covidData.setCaseCount(row.getInt("new_cases"));
      covidData.setTotalDeathCount(row.getInt("total_deaths"));
      covidData.setDeathCount(row.getInt("new_deaths"));
      covidData.setTotalTestCount(row.getInt("total_tests"));
      covidData.setTestCount(row.getInt("new_tests"));

      countryCovidData.get(countryCode).add(covidData);
    }
  } catch (Exception e) {
    println("Error while reading Covid data");
    println(e);
  }
  
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
        
        alpha2Alpha3.put(code, row.getString("Alpha-3_code"));
        alpha3Alpha2.put(row.getString("Alpha-3_code"), code);
        countries.put(code, country);
      }
  }
}
