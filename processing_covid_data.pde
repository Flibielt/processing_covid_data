import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Date;

PShape map, hungary;
int svgX, svgY;
HashMap<String, Country> countries;
HashMap<String, List<CovidData>> countryCovidData;

int dataRows;
int dayInterval = 10;
int volumeInterval = 10;

void setup() {
  //size(1024, 800);
  fullScreen();
  svgX = 10;
  svgY = 10;
  
  map = loadShape("countries_of_europe.svg");
  map.disableStyle();
  
  hungary = map.getChild("hu");
  background(255);
  
  loadCountries();
  loadCovidData();
}

void loadCovidData() {
  Table covidDataTable = loadTable("owid-covid-data-europe.csv", "header");
  countryCovidData = new HashMap();

  try {
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-mm-dd");

    for (TableRow row : covidDataTable.rows()) {
      String countryCode = row.getString("iso_code");

      if (!countryCovidData.containsKey(countryCode)) {
        List<CovidData> covidDatas = new ArrayList();
        countryCovidData.put(countryCode, covidDatas);
      }

      CovidData covidData = new CovidData();
      Date date = simpleDateFormat.parse(row.getString("date"));

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
