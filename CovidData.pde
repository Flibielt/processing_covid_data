class CovidData {

  private String countryName;
  private String countryCode;
  private LocalDate date;

  private Integer totalCaseCount;
  private Integer caseCount;

  private Integer totalDeathCount;
  private Integer deathCount;

  private Integer totalTestCount;
  private Integer testCount;

  public CovidData() {
  }

  public CovidData(String countryName, String countryCode, LocalDate date, Integer totalCaseCount, Integer caseCount, 
  Integer totalDeathCount, Integer deathCount, Integer totalTestCount, Integer testCount) {
    this.countryName = countryName;
    this.countryCode = countryCode;
    this.date = date;
    this.totalCaseCount = totalCaseCount;
    this.caseCount = caseCount;
    this.totalDeathCount = totalDeathCount;
    this.deathCount = deathCount;
    this.totalTestCount = totalTestCount;
    this.testCount = testCount;
  }

  public String getCountryName() {
    return countryName;
  }
  
  public void setCountryName(String countryName) {
    this.countryName = countryName;
  }
  
  public String getCountryCode() {
    return countryCode;
  }
  
  public void setCountryCode(String countryCode) {
    this.countryCode = countryCode;
  }
  
  public LocalDate getDate() {
    return date;
  }
  
  public void setDate(LocalDate date) {
    this.date = date;
  }
  
  public Integer getTotalCaseCount() {
    return totalCaseCount;
  }
  
  public void setTotalCaseCount(int totalCaseCount) {
    this.totalCaseCount = totalCaseCount;
  }
  
  public Integer getCaseCount() {
    return caseCount;
  }
  
  public void setCaseCount(int caseCount) {
    this.caseCount = caseCount;
  }
  
  public Integer getTotalDeathCount() {
    return totalDeathCount;
  }
  
  public void setTotalDeathCount(int totalDeathCount) {
    this.totalDeathCount = totalDeathCount;
  }
  
  public Integer getDeathCount() {
    return deathCount;
  }
  
  public void setDeathCount(int deathCount) {
    this.deathCount = deathCount;
  }
  
  public Integer getTotalTestCount() {
    return totalTestCount;
  }
  
  public void setTotalTestCount(int totalTestCount) {
    this.totalTestCount = totalTestCount;
  }
  
  public Integer getTestCount() {
    return testCount;
  }
  
  public void setTestCount(int testCount) {
    this.testCount = testCount;
  }

  public float getData(DataType dataType) {
    Integer value = -1;
    if (dataType == DataType.CASE_COUNT) {
      value = getCaseCount();
    } else if (dataType == DataType.DEATH_COUNT) {
      value = getDeathCount();
    } else if (dataType == DataType.TEST_COUNT) {
      value = getTestCount();
    }

    return value;
  }

  public void setData(DataType dataType, float data) {
    if (dataType == DataType.CASE_COUNT) {
      setCaseCount(int(data));
    } else if (dataType == DataType.DEATH_COUNT) {
      setDeathCount(int(data));
    } else if (dataType == DataType.TEST_COUNT) {
      setTestCount(int(data));
    }
  }

}
