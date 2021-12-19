class DataVisualization {
  private int dataMin = 0, dataMax;
  private LocalDate dateMin = LocalDate.now(), dateMax, startDate;
  private float previousValue = 0.0;
  private float plotX1, plotX2, plotY1, plotY2;
  private Set<String> countryCodes;

  private DataType dataType;

  public void addCountry(String countryCode) {
    countryCodes.add(countryCode);
    resetMaxData();
    findMaxData();
  }

  public void removeCountry(String countryCode) {
    countryCodes.remove(countryCode);
    resetMaxData();
    findMaxData();
  }

  private void resetMaxData() {
    dataMin = 0;
    dataMax = 0;
    dateMin = LocalDate.now();
    startDate = LocalDate.parse("2018-01-01");
    dateMax = LocalDate.parse("2000-01-01");
  }

  public Set<String> getCountryCodes() {
    return countryCodes;
  }

  public void setDataType(DataType dataType) {
    this.dataType = dataType;
    resetMaxData();
    findMaxData();
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

    if (covidDataList.get(0).getDate().isBefore(dateMin)) {
      dateMin = covidDataList.get(0).getDate();
    }

    if (covidDataList.get(covidDataList.size() - 1).getDate().isAfter(dateMax)) {
      dateMax = covidDataList.get(covidDataList.size() - 1).getDate();
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

  public void drawCountryNamesWithColor() {
    float x, y;
    x = plotX1;
    y = plotY2 + 50;

    for (String alpha3Code : countryCodes) {
      String alpha2Code = alpha3Alpha2.get(alpha3Code);
      String countryName;
      color countryColor;

      Country country = countries.get(alpha2Code);
      countryName = country.getName();
      countryColor = country.getColor();

      fill(countryColor);
      textSize(20);
      textAlign(LEFT);

      text(countryName, x, y);
      x += textWidth(countryName) + 10;
    }
  }

  public void drawTimeLabel() {
    long daysBetween = getDaysBetween(dateMin, dateMax);

    fill(0);
    textSize(10);
    textAlign(CENTER);
    stroke(224);

    for (int day = 0; day < daysBetween; day++) {
      if (day % 75 == 0) {
        float x = map(day, 0, daysBetween, plotX1, plotX2);
        LocalDate date = dateMin.plusDays(day);
        text(date.toString(), x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }

    stroke(0);
  }

  public void drawVolumeLabel() {
    int tickMark;
    float y;
    fill(0);
    textSize(10);
    textAlign(RIGHT);
    stroke(224);
    
    volumeIntervalMinor = dataMax / 5; 

    for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
      y = map(v, dataMin, dataMax, plotY2, plotY1);  
      float textOffset = textAscent() / 2;  // Center vertically
      if (v == dataMin) {
        textOffset = 0;                   // Align by the bottom
      } else if (v == dataMax) {
        textOffset = textAscent();        // Align by the top
      }
      text(floor(v), plotX1 - 10, y + textOffset);
      line(plotX1 - 4, y, plotX1, y);     // Draw major tick
    }

    stroke(0);
  }
  
  public void drawDataCurve() {
    for (String countryCode : countryCodes) {
      drawDataCurve(countryCode);
    }
  }

  private void drawDataCurve(String countryCode) {
    List<CovidData> covidData = countryCovidData.get(countryCode);
    long dateMinDays, dateMaxDays, currentDays;
    Country country = null;

    for (Country c : countries.values()) {
      if (c.getAlphaCode3().equals(countryCode)) {
        country = c;
        break;
      }
    }

    if (covidData == null || country == null) {
      return;
    }

    dateMinDays = getDaysBetween(startDate, dateMin);
    dateMaxDays = getDaysBetween(startDate, dateMax);
    
    noFill();
    stroke(country.getColor());
    beginShape();
    
    for (int row = 0; row < covidData.size(); row++) {
      float value = 0;
      value = covidData.get(row).getData(dataType);
      
      // Manage missing data
      if (row > 0 && value <= 0 && previousValue > (dataMax / 40)) {
        value = previousValue;
        covidData.get(row).setData(dataType, value);
      }
      
      // currentDays = TimeUnit.DAYS.convert(covidData.get(row).getDate().getTime() - startDate.getTime(), TimeUnit.MILLISECONDS);
      currentDays = getDaysBetween(startDate, covidData.get(row).getDate());
      float x = map(currentDays, dateMinDays, dateMaxDays, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // double the curve points for the start and stop
      if ((row == 0) || (row == covidData.size()-1)) {
        curveVertex(x, y);
      }

      previousValue = value;
    }

    endShape();
    stroke(0);
  }

  public DataVisualization() {
    countryCodes = new HashSet();

    try {
      startDate = LocalDate.parse("2018-01-01");
      dateMax = LocalDate.parse("2000-01-01");
    } catch (Exception e) {
      println(e.getMessage());
    }
  }

  public DataVisualization(float plotX1, float plotY1, float plotX2, float plotY2) {
    this.plotX1 = plotX1;
    this.plotY1 = plotY1;
    this.plotX2 = plotX2;
    this.plotY2 = plotY2;

    countryCodes = new HashSet();

    try {
      startDate = LocalDate.parse("2018-01-01");
      dateMax = LocalDate.parse("2000-01-01");
    } catch (Exception e) {
      println(e.getMessage());
    }
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
}
