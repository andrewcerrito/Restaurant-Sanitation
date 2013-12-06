// Code for start date 01/01/01. end date 12/31/99
import java.util.Date;
import java.text.SimpleDateFormat;

Table restaurants;
Table violations;
ArrayList<Restaurants> restList = new ArrayList();
ArrayList<Violcodes> violList = new ArrayList();

//BufferedReader reader;
//PrintWriter writer;

PFont font;

void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth();

  restaurants = loadTable("Restaurant-Inspections.csv", "header");
  violations = loadTable("vermincodes.csv", "header");

  for (TableRow row : restaurants.rows()) {
    String name = row.getString("DBA");
    String violCode = row.getString("VIOLCODE");
    String grade = row.getString("CURRENTGRADE");
    Restaurants restaurant = new Restaurants(name, violCode, grade);
    restList.add(restaurant);
  }

  for (TableRow row : violations.rows()) {
    String violationText = row.getString("DESC");
    String violCode = row.getString("CODE");
    Violcodes violation = new Violcodes(violationText, violCode);
    violList.add(violation);
  }

  searchAgrade();
  searchBgrade();
  searchCgrade();
  searchGradePending();
}


void draw() {
}

// Grade searching functions

void searchAgrade() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    if (r.grade.equals("A")) {
      restCount++;
      for (Violcodes v: violList) {
        if (r.violCode.equals(v.violCode)) violCount++;
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  println("There are " + (int) restCount + " A-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

void searchBgrade() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    if (r.grade.equals("B")) {
      restCount++;
      for (Violcodes v: violList) {
        if (r.violCode.equals(v.violCode)) violCount++;
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  println("There are " + (int) restCount + " B-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

void searchCgrade() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    if (r.grade.equals("C")) {
      restCount++;
      for (Violcodes v: violList) {
        if (r.violCode.equals(v.violCode)) violCount++;
      }
    }
  }
   float percentage = (violCount/restCount) * 100;
  println("There are " + (int) restCount + " C-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

void searchGradePending() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    if (r.grade.equals("P") || r.grade.equals("Z")) {
      restCount++;
      for (Violcodes v: violList) {
        if (r.violCode.equals(v.violCode)) violCount++;
      }
    }
  }
   float percentage = (violCount/restCount) * 100;
  println("There are " + (int) restCount + " Grade Pending establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

// Borough searching functions

void searchManhattan() {
  
}

