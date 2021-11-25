import java.util.Date;

class CovidData {

    private String countryName;
    private String countryCode;
    private Date date;

    private int totalCaseCount;
    private int caseCount;

    private int totalDeathCount;
    private int deathCount;

    private int totalTestCount;
    private int testCount;

    public CovidData() {
    }

    public CovidData(String countryName, String countryCode, Date date, int totalCaseCount, int caseCount, 
    int totalDeathCount, int deathCount, int totalTestCount, int testCount) {
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
    
    public Date getDate() {
        return date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    public int getTotalCaseCount() {
        return totalCaseCount;
    }
    
    public void setTotalCaseCount(int totalCaseCount) {
        this.totalCaseCount = totalCaseCount;
    }
    
    public int getCaseCount() {
        return caseCount;
    }
    
    public void setCaseCount(int caseCount) {
        this.caseCount = caseCount;
    }
    
    public int getTotalDeathCount() {
        return totalDeathCount;
    }
    
    public void setTotalDeathCount(int totalDeathCount) {
        this.totalDeathCount = totalDeathCount;
    }
    
    public int getDeathCount() {
        return deathCount;
    }
    
    public void setDeathCount(int deathCount) {
        this.deathCount = deathCount;
    }
    
    public int getTotalTestCount() {
        return totalTestCount;
    }
    
    public void setTotalTestCount(int totalTestCount) {
        this.totalTestCount = totalTestCount;
    }
    
    public int getTestCount() {
        return testCount;
    }
    
    public void setTestCount(int testCount) {
        this.testCount = testCount;
    }

}
