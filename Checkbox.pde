float checkBoxX1, checkBoxY1, checkBoxwidth;

void drawCheckBox() {
    checkBoxX1 = svgX + 20;
    checkBoxY1 = svgY + map.height + 20;

    checkBoxwidth = 20;
    
    rectMode(CORNER);
    fill(0);
    rect(checkBoxX1 - 1, checkBoxY1 - 1, checkBoxwidth + 2, checkBoxwidth + 2);

    if (heatmap) {
        fill(color(124,252,0));
    } else {
        fill(255);
    }
    rect(checkBoxX1, checkBoxY1, checkBoxwidth, checkBoxwidth);

    fill(0);
    textSize(20);
    textAlign(LEFT);
    String checkBoxText;
    if (heatmap) {
        checkBoxText = "Disable heatmap";
    } else {
        checkBoxText = "Enable heatmap";
    }
    text(checkBoxText, checkBoxX1 + checkBoxwidth + 10, checkBoxY1 + 17);
}

void checkClickOnCheckBox() {
    if (checkBoxX1 <= mouseX && checkBoxY1 <= mouseY) {
        if (checkBoxX1 + checkBoxwidth >= mouseX && checkBoxY1 + checkBoxwidth >= mouseY) {
            heatmap = !heatmap;
        }
    }
}
