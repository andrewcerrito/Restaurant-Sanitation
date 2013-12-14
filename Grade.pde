class Grade {
  int restTotal;
  int restViol;
  int recentViol;
  float recentPercentage;
  float percentage;
  int counter1, counter2 = 0;
  float counter3, counter4 = 0;
  int opacity= 0;
  int titleOpacity =0;


  Grade(int t_total, int t_viol, int t_recent, float t_percentage, float t_recentPercent) {
    restTotal = t_total;
    restViol = t_viol;
    recentViol = t_recent;
    percentage = fixDec(t_percentage, 2);
    recentPercentage = fixDec(t_recentPercent, 2);
  }

  void displayData(String grade, String hashmapKey) {
    boolean dataTrigger = dataBools.get(hashmapKey);
    if (dataTrigger) {
      counter3 = fixDec(counter3, 2);
      counter4 = fixDec(counter4, 2);
     
     // style for big numbers
      pushStyle();
      textFont(bigNumbers);
      fill(255, 159, 3);
      text(counter1, 50, 175);
      text(counter2, 50, 315);
      text(counter3 + "%", 50, 455);
      text(counter4 + "%", 50, 595);
      popStyle();

      // if statements that govern the numbers-increasing animation
      if (counter1 < restTotal) counter1 += ((int)restTotal/((int)(random(70, 80))));
      if (counter2 < restViol) counter2 += ((int)restViol/((int)(random(70, 80))));     
      if (counter3 < percentage) counter3 +=(percentage/random(70, 80));
      if (counter4 < recentPercentage) counter4 +=(recentPercentage/random(70, 80));
      if (counter1 > restTotal) counter1 = restTotal;
      if (counter2 > restViol) counter2 = restViol;  
      if (counter3 > percentage) counter3 = percentage;
      if (counter4 > recentPercentage) counter4 = recentPercentage;

//style for other text
      pushStyle();
      textFont(headerFont);
      fill(255,titleOpacity);
      text(grade + ":", 35, 55);
      textFont(menuFont);
      fill(255, opacity);
      text("total restaurants in this grade level.", 115, 210);
      text("restaurants cited for vermin violations.", 115, 350);
      text("percentage ratio of vermin violations.", 115, 490);
      text("of these violations were within the past year.", 115, 630);
      popStyle();
      if (opacity < 160) opacity +=3;
      if (titleOpacity < 255) titleOpacity +=4;
      if (opacity > 160) opacity = 160;
      if (titleOpacity > 255) titleOpacity = 255;
      
    }
    if (!dataTrigger) {
      counter1 = 0;
      counter2 = 0;
      counter3 = 0;
      counter4 = 0;
      opacity = 0;
      titleOpacity = 0;
    }
  }

  //  void displayData(String grade, String hashmapKey) {
  //    boolean dataTrigger = dataBools.get(hashmapKey);
  //    if (dataTrigger) {
  //      if (grade == "Pending") text("For all Grade Pending restaurants:", 20,20);
  //      else { text("For all " + grade +"-grade restaurants:", 20, 20);}
  //      text("Total number of restaurants: " + restTotal, 20, 50);
  //      text("Number of restaurants with vermin violations: " + restViol, 20, 80);
  //      text("Percentage of restaurants with with vermin violations: " + percentage + "%", 20, 110);
  //    }
  //  }
}

