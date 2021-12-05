import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Date;
import java.util.Set;

PShape map, hungary;
int svgX, svgY;
int defaultDistance = 20;
HashMap<String, Country> countries;
HashMap<String, List<CovidData>> countryCovidData;
Set<String> selectedCountries;

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
      if (selectedCountries.contains(code)) {
        selectedCountries.remove(code);
      } else {
        selectedCountries.add(code);
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

  dataVisualization.setCountryCode("HUN");
  dataVisualization.setDataType(DataType.CASE_COUNT);
  dataVisualization.findMaxData();
  dataVisualization.drawTimeLabel();
  dataVisualization.drawVolumeLabel();
  dataVisualization.drawDataCurve();
  

}
