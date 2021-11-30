import java.text.SimpleDateFormat;
import java.text.DateFormat;

class DataVisualization {
  private int plotX1;
  private int plotX2;
  private int plotY1;
  private int plotY2;
  private DateFormat dateFormat;

  public DataVisualization() {
    dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
  }

  public DataVisualization(int plotX1, int plotY1, int plotX2, int plotY2) {
    this.plotX1 = plotX1;
    this.plotY1 = plotY1;
    this.plotX2 = plotX2;
    this.plotY2 = plotY2;

    dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
  }

  public void setPlotX1(int plotX1) {
    this.plotX1 = plotX1;
  }

  public int getPlotX1() {
    return plotX1;
  }

  public void setPlotY1(int plotY1) {
    this.plotY1 = plotY1;
  }

  public int getPlotY1() {
    return plotY1;
  }

  public void setPlotX2(int plotX2) {
    this.plotX2 = plotX2;
  }

  public int getPlotX2() {
    return plotX2;
  }

  public void setPlotY2(int plotY2) {
    this.plotY2 = plotY2;
  }

  public int getPlotY2() {
    return plotY2;
  }

  public void drawTimeLabel(String countryCode) {
    List<CovidData> covidData = countryCovidData.get(countryCode);
    fill(0);
    textSize(10);
    textAlign(CENTER);

    // Use thin, gray lines to draw the grid
    stroke(224);
    strokeWeight(1);

    for (int row = 0; row < rowCount; row++) { //<>//
      if (row % rowCount == 0) {
        float x = map(row, 0, rowCount, plotX1, plotX2);
        String dateStr = dateFormat.format(covidData.get(row).getDate());
        text(dateStr, x, plotY2 + textAscent() + 10); //<>//
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

    for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
      if (v % volumeIntervalMinor == 0) {     // If a tick mark
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

  public void drawDataCurve(String countryCode, DataType dataType) {
    List<CovidData> covidData = countryCovidData.get(countryCode);

    beginShape();
    
    for (int row = 0; row < rowCount; row++) {
      float value = 0;
      if (dataType == DataType.CASE_COUNT) {
        value = covidData.get(row).getCaseCount();
      } else if (dataType == DataType.DEATH_COUNT) {
        value = covidData.get(row).getDeathCount();
      } else if (dataType == DataType.TEST_COUNT) {
        value = covidData.get(row).getTestCount();
      }

      // TODO: Set dayMin and dayMax
      // float x = map(row, dayMin, dayMax, plotX1, plotX2);
      float x = map(row, 0, rowCount, plotX1, plotX2);
      float y = map(value, dataMin, dataMax, plotY2, plotY1);
      
      curveVertex(x, y);
      // double the curve points for the start and stop
      if ((row == 0) || (row == rowCount-1)) {
        curveVertex(x, y);
      }
    }

    endShape();
  }
}
