/**
 * Scrollbar. 
 * 
 * Move the scrollbars left and right to change the positions of the images. 
 */
class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  int daysBetween;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    int plusDay;

    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;

    daysBetween = int(getDaysBetween(globalMinDate, globalMaxDate));

    plusDay = int(map(spos, xpos, xpos + swidth, 0, daysBetween));
    selectedDate = globalMinDate.plusDays(plusDay);
    updateCovidData();
  }

  void update() {
    int plusDay;

    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
      updateCovidData();
    }

    plusDay = int(map(spos, xpos, xpos + swidth, 0, daysBetween));
    selectedDate = globalMinDate.plusDays(plusDay);
  }

  void updateCovidData() {
    covidDataForDate = Collections.emptyList();
    covidDataForDate = new ArrayList();

    for (String key : countryCovidData.keySet()) {
      for (CovidData covidData : countryCovidData.get(key)) {
        if (covidData.getDate().equals(selectedDate)) {
          covidDataForDate.add(covidData);
          break;
        }
      }
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    rectMode(CORNER);
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);

    fill(0);
    textSize(15);
    textAlign(LEFT);
    text(globalMinDate.toString(), xpos, ypos + sheight + 20);

    textAlign(RIGHT);
    text(globalMaxDate.toString(), xpos + swidth, ypos + sheight + 20);

    stroke(0);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
