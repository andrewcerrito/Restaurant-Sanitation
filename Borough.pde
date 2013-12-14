class Borough {
  int restTotal;
  int restViol;
  int recentViol;
  float percentage;
  float recentPercentage;



  Borough(int t_total, int t_viol, int t_recent, float t_percentage, float t_recentPercent) {
    restTotal = t_total;
    restViol = t_viol;
    recentViol = t_recent;
    percentage = fixDec(t_percentage,2);
    recentPercentage = fixDec(t_recentPercent,2);
  }


  void displayData(String borough, String hashmapKey) {
    boolean dataTrigger = dataBools.get(hashmapKey);
    if (dataTrigger) {
      pushStyle();
      textFont(bigNumbers);
      fill(255, 159, 3);
      text(restTotal,50,175);
      text(restViol,50,315);
      text(percentage + "%",50,455);
      text(recentPercentage + "%",50,595);
     
      popStyle();
      
      pushStyle();
      textFont(headerFont);
      fill(255);
      text(borough + ":", 35, 55);
      textFont(menuFont);
      fill(255,160);
      text("total restaurants in this borough.", 115, 210);
      text("restaurants cited for vermin violations.", 115, 350);
      text("percentage ratio of vermin violations.", 115, 490);
      text("of these violations were within the past year.", 115, 630);
      popStyle();
    }
  }
  
//  void displayData(String borough, String hashmapKey) {
//    boolean dataTrigger = dataBools.get(hashmapKey);
//    if (dataTrigger) {
//      text("Restaurants in " + borough + ":", 20, 20);
//      text("Total number of restaurants: " + restTotal, 20, 50);
//      text("Number of restaurants with vermin violations: " + restViol, 20, 80);
//      text("Percentage of restaurants with with vermin violations: " + percentage + "%", 20, 110);
//    }
//  }
}

