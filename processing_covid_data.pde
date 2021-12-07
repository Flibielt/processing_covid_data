import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.time.format.DateTimeFormatter;

PShape map;
Set<String> selectedCountries;
HashMap<String, Country> countries;
HashMap<String, List<CovidData>> countryCovidData;
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DataType[] dataTypes = {DataType.CASE_COUNT, DataType.DEATH_COUNT, DataType.TEST_COUNT};

// Visualizing the data
DataVisualization dataVisualization;
HScrollbar hs1;

int rowCount;
int svgX, svgY;
int dayMin, dayMax;
int dayInterval = 10;
int volumeInterval = 20;
int defaultDistance = 20;
int volumeIntervalMinor = 5;

float tabPad = 10;
int currentColumn = 0;
float tabTop, tabBottom;
float[] tabLeft, tabRight;
float plotX1, plotX2, plotY1, plotY2;

void setup() {
  fullScreen();
  svgX = defaultDistance;
  svgY = defaultDistance;
  
  map = loadShape("countries_of_europe.svg");
  map.disableStyle();
  
  background(255);
  
  loadCountries();
  loadCovidData();
  
  plotX1 = svgX + map.width + 75;
  plotY1 = svgY + 50;
  plotX2 = width - defaultDistance;
  plotY2 = height - plotY1 - 100;

  selectedCountries = new HashSet();
  dataVisualization = new DataVisualization(plotX1, plotY1, plotX2, plotY2);
  dataVisualization.setDataType(dataTypes[0]);

  hs1 = new HScrollbar(0, height - 100, 200, 16, 1);
}

void mouseClicked() {
  checkClickOnMap();
  checkClickOnDataTypes();
}

void draw() {
  background(255);

  hs1.update();
  hs1.display();

  fill(255);
  shape(map, svgX, svgY);
  textSize(12);
  
  for (String code : countries.keySet()) {
    Country country = countries.get(code);

    if (country.isMouseOver()) {
      fill(200);
      shape(country.getShape(), svgX, svgY);
      fill(0);
      text(country.getName(), mouseX, mouseY);
    }

    if (selectedCountries.contains(country.getAlphaCode3())) {
      fill(country.getColor());
      shape(country.getShape(), svgX, svgY);
      fill(255);
    }
  }

  if (selectedCountries.size() > 0) {
    dataVisualization.drawTimeLabel();
    dataVisualization.drawVolumeLabel();
    dataVisualization.drawDataCurve();

    drawTitleTabs();
  }
}
