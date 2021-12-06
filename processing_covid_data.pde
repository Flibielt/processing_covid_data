import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Date;
import java.time.Period;
import java.util.concurrent.TimeUnit;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

boolean first = true;
PShape map, hungary;
int svgX, svgY;
int defaultDistance = 20;
HashMap<String, Country> countries;
HashMap<String, List<CovidData>> countryCovidData;
Set<String> selectedCountries;
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

// Visualizing the data
DataVisualization dataVisualization;

int rowCount;
int dayMin, dayMax;
int dayInterval = 10;
int volumeInterval = 20;
int volumeIntervalMinor = 5;

void setup() {
  fullScreen();
  svgX = defaultDistance;
  svgY = defaultDistance;
  
  map = loadShape("countries_of_europe.svg");
  map.disableStyle();
  
  hungary = map.getChild("hu");
  background(255);
  
  loadCountries();
  loadCovidData();
  
  float plotX1 = svgX + map.width + 75;
  float plotY1 = svgY;
  float plotX2 = width - defaultDistance;
  float plotY2 = height - plotY1 - 100;

  selectedCountries = new HashSet();
  dataVisualization = new DataVisualization(plotX1, plotY1, plotX2, plotY2);
}

void mouseClicked() {
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

  if (selectedCountries.size() > 0) {
    dataVisualization.setDataType(DataType.CASE_COUNT);
    dataVisualization.findMaxData();
    dataVisualization.drawTimeLabel();
    dataVisualization.drawVolumeLabel();
    dataVisualization.drawDataCurve();
  }
}
