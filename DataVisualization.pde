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

    for (int row = 0; row < dataRows; row++) {
      if (row % dataRows == 0) {
        float x = map(row, 0, dataRows, plotX1, plotX2);
        String dateStr = dateFormat.format(covidData.get(row).getDate());
        text(dateStr, x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }
  }

  public void drawVolumeLabel() {
  }

  public void drawDataCurve() {
  }
}
