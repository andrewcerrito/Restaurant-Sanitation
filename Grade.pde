class Grade {
  int restTotal;
  int restViol;
  int recentViol;
  float recentPercentage;
  float percentage;


  Grade(int t_total, int t_viol, int t_recent, float t_percentage, float t_recentPercent) {
    restTotal = t_total;
    restViol = t_viol;
    recentViol = t_recent;
    percentage = t_percentage;
    recentPercentage = t_recentPercent;
  }

  void displayData(String grade, String hashmapKey) {
    boolean dataTrigger = dataBools.get(hashmapKey);
    if (dataTrigger) {
      if (grade == "Pending") text("For all Grade Pending restaurants:", 20,20);
      else { text("For all " + grade +"-grade restaurants:", 20, 20);}
      text("Total number of restaurants: " + restTotal, 20, 50);
      text("Number of restaurants with vermin violations: " + restViol, 20, 80);
      text("Percentage of restaurants with with vermin violations: " + percentage + "%", 20, 110);
    }
  }
}

