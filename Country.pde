class Country {
  private String name;
  private String alphaCode2;
  private String alphaCode3;
  private PShape shape;
  private color countryColor;

  public Country() {
  }

  public Country(String name, String alphaCode2, String alphaCode3, PShape shape) {
    this.name = name;
    this.alphaCode3 = alphaCode3;
    this.alphaCode2 = alphaCode2;
    this.shape = shape;
  }

  public boolean isMouseOver() {
    return shape.contains((mouseX - svgX), (mouseY - svgY));
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }

  public void setAlphaCode2(String alphaCode2) {
    this.alphaCode2 = alphaCode2;
  }

  public String getAlphaCode2() {
    return alphaCode2;
  }

  public void setAlphaCode3(String alphaCode3) {
    this.alphaCode3 = alphaCode3;
  }

  public String getAlphaCode3() {
    return alphaCode3;
  }

  public void setShape(PShape shape) {
    this.shape = shape;
  }

  public PShape getShape() {
    return shape;
  }

  public void setColor(color c) {
    this.countryColor = c;
  }

  public color getColor() {
    return countryColor;
  }

}
