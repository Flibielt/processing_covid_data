import java.text.SimpleDateFormat;
import java.text.DateFormat;

class DataVisualization {
  private int dataMax;
  private int dataMin = 0;
  private float previousValue = 0.0;
  private float plotX1, plotX2, plotY1, plotY2;
  private Set<String> countryCodes;

  private DataType dataType;
  private DateFormat dateFormat;

  public DataVisualization() {
    countryCodes = new HashSet();
    dateFormat = new SimpleDateFormat("yyyy.mm.dd");
  }

  public DataVisualization(float plotX1, float plotY1, float plotX2, float plotY2) {
    this.plotX1 = plotX1;
    this.plotY1 = plotY1;
    this.plotX2 = plotX2;
    this.plotY2 = plotY2;

    countryCodes = new HashSet();
    dateFormat = new SimpleDateFormat("yyyy.mm.dd");
  }

  public void setPlotX1(float plotX1) {
    this.plotX1 = plotX1;
  }

  public float getPlotX1() {
    return plotX1;
  }

  public void setPlotY1(float plotY1) {
    this.plotY1 = plotY1;
  }

  public float getPlotY1() {
    return plotY1;
  }

  public void setPlotX2(float plotX2) {
    this.plotX2 = plotX2;
  }

  public float getPlotX2() {
    return plotX2;
  }

  public void setPlotY2(float plotY2) {
    this.plotY2 = plotY2;
  }

  public float getPlotY2() {
    return plotY2;
  }

  public void addCountry(String countryCode) {
    countryCodes.add(countryCode);
  }

  public void removeCountry(String countryCode) {
    countryCodes.remove(countryCode);
  }

  public Set<String> getCountryCodes() {
    return countryCodes;
  }

  public void setDataType(DataType dataType) {
    this.dataType = dataType;
  }

  public void findMaxData() {
    for (String countryCode : countryCodes) {
      findMaxData(countryCode);
    }
  }

  private void findMaxData(String countryCode) {
    List<CovidData> covidDataList = countryCovidData.get(countryCode);

    if (covidDataList == null) {
      return;
    }

    for (CovidData covidData : covidDataList) {
      if (dataType == DataType.CASE_COUNT) {
        if (dataMax < covidData.getCaseCount()) {
          dataMax = covidData.getCaseCount();
        }
      } else if (dataType == DataType.DEATH_COUNT) {
        if (dataMax < covidData.getDeathCount()) {
          dataMax = covidData.getDeathCount();
        }
      } else if (dataType == DataType.TEST_COUNT) {
        if (dataMax < covidData.getTestCount()) {
          dataMax = covidData.getTestCount();
        }
      }
    }
  }

  public void drawTimeLabel() {
    String countryCode;
    countryCode = countryCodes.iterator().next();
    List<CovidData> covidData = countryCovidData.get(countryCode);

    if (covidData == null) {
      return;
    }

    rowCount = covidData.size();
    fill(0);
    textSize(10);
    textAlign(CENTER);

    // Use thin, gray lines to draw the grid
    stroke(224);
    strokeWeight(1);

    for (int row = 0; row < rowCount; row++) {
      if (row % 75 == 0) {
        float x = map(row, 0, rowCount, plotX1, plotX2);
        String dateStr = dateFormat.format(covidData.get(row).getDate());
        text(dateStr, x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }
  }

  public void drawVolumeLabel() {
    fill(0);
    textSize(10);
    textAlign(RIGHT);
    
    stroke(128);
    strokeWeight(1);
      
    //volumeIntervalMinor = int(dataMax / (plotY2 - plotY1)) / 1000;
    
    volumeIntervalMinor = 100; 
    
    for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
      if (v % 2500 == 0) {     // If a tick mark
        float y = map(v, dataMin, dataMax, plotY2, plotY1);  
        if (v % volumeInterval == 0) {        // If a major tick mark
          float textOffset = textAscent()/2;  // Center vertically
          if (v == dataMin) {
            textOffset = 0;                   // Align by the bottom
          } else if (v == dataMax) {
            textOffset = textAscent();        // Align by the top
          }
          text(floor(v), plotX1 - 10, y + textOffset);
          line(plotX1 - 4, y, plotX1, y);     // Draw major tick
        } else {
          //line(plotX1 - 2, y, plotX1, y);     // Draw minor tick
        }
      }
    }
  }
  
  public void drawDataCurve() {
    for (String countryCode : countryCodes) {
      drawDataCurve(countryCode);
    }
  }

  private void drawDataCurve(String countryCode) {
    List<CovidData> covidData = countryCovidData.get(countryCode);

    if (covidData == null) {
      return;
    }
    
    noFill();

    beginShape();
    
    for (int row = 0; row < covidData.size(); row++) {
      float value = 0;
      value = covidData.get(row).getData(dataType);
      
      // Manage missing data
      if (row > 0 && value <= 0 && previousValue > (dataMax / 40)) {
        value = previousValue;
        covidData.get(row).setData(dataType, value);
      }
      
      float x = map(row, 0, covidData.size(), plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // double the curve points for the start and stop
      if ((row == 0) || (row == covidData.size()-1)) {
        curveVertex(x, y);
      }

      previousValue = value;
    }

    endShape();
  }
}
