class Borough {
  int restTotal;
  int restViol;
  float percentage;

  Borough(int t_total, int t_viol, float t_percentage) {
    restTotal = t_total;
    restViol = t_viol;
    percentage = t_percentage;
  }


  void displayData(String borough, String hashmapKey) {
    boolean dataTrigger = dataBools.get(hashmapKey);
    if (dataTrigger) {
      text("Restaurants in " + borough + ":", 20, 20);
      text("Total number of restaurants: " + restTotal, 20, 50);
      text("Number of restaurants with vermin violations: " + restViol, 20, 80);
      text("Percentage of restaurants with with vermin violations: " + percentage + "%", 20, 110);
    }
  }
}

