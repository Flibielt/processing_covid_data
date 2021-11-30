import java.text.SimpleDateFormat;  
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Date;

PShape map, hungary;
int svgX, svgY;
HashMap<String, Country> countries;
HashMap<String, List<CovidData>> countryCovidData;
DataVisualization dataVisualization;

int rowCount;
int dataMin, dataMax;
int dayMin, dayMax;
int dayInterval = 10;
int volumeInterval = 20;
int volumeIntervalMinor = 5;

void setup() {
  fullScreen();
  svgX = 10;
  svgY = 10;
  dataMin = 0;
  
  map = loadShape("countries_of_europe.svg");
  map.disableStyle();
  
  hungary = map.getChild("hu");
  background(255);
  
  loadCountries();
  loadCovidData();

  dataVisualization = new DataVisualization(200, 200, 1500, 1500);
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

  dataVisualization.drawTimeLabel("HUN");
  dataVisualization.drawVolumeLabel();
  dataVisualization.drawDataCurve("HUN", DataType.CASE_COUNT);

}
