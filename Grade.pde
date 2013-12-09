class Grade {
  int restTotal;
  int restViol;
  float percentage;
  
  
  Grade(int t_total, int t_viol, float t_percentage) {
    restTotal = t_total;
    restViol = t_viol;
    percentage = t_percentage;
    
  }
  
  void displayData(String grade) {
    text("For all " + grade +"-grade restaurants:",20, 20);
    text("Total number of restaurants: " + restTotal, 20, 50);
    text("Number of restaurants with vermin violations: " + restViol, 20, 80);
    text("Percentage of restaurants with with vermin violations: " + percentage + "%", 20, 110);
  }
}
