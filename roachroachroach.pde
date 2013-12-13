
// Credits:
// Christina Carter helped with clickable text!
// Sam Brenner helped with nested menus that no longer exist!
// Valerie Chen convinced me to keep working on this 
// instead of printing out miniature restaurant bar areas like an insane person!


import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Map;

Table restaurants;
Table violations;
ArrayList<Restaurants> restList = new ArrayList();
ArrayList<Violcodes> violList = new ArrayList();

//BufferedReader reader;
//PrintWriter writer;

PFont menuFont;

long lastClickTime = 0;

Grade gradeA, gradeB, gradeC, gradeP;
Borough manhattan, queens, brooklyn, bronx, SI;
textButton gradeTitle, boroughTitle, gradeAbutton, gradeBbutton, gradeCbutton, gradePbutton, manhattanbutton, queensbutton, brooklynbutton, bronxbutton, SIbutton;

boolean gradeBool, boroughBool, aBool, bBool, cBool, pBool, manhattanBool, queensBool, brooklynBool, bronxBool, SIBool;
boolean mouseBufferOK = false;
boolean mouseClicked = false;
boolean aData, bData, cData, pendData, manhattanData, queensData, brooklynData, bronxData, SIData;

HashMap<String, Boolean> dataBools = new HashMap<String, Boolean>();


// Defines what starting date counts as "recent" to determine recent vermin violations
String checkRecent = "12-01-2012";
Date isRecent;
// float recentEpoch;


void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth();
  menuFont = createFont("AvenirNext-UltraLight", 24);
  //menuFont = createFont("AvenirNextCondensed-UltraLight", 24);

  dataBools.put("aData", false);
  dataBools.put("bData", false);
  dataBools.put("cData", false);
  dataBools.put("pendData", false);
  dataBools.put("manhattanData", false);
  dataBools.put("queensData", false);
  dataBools.put("brooklynData", false);
  dataBools.put("bronxData", false);
  dataBools.put("SIData", false);

  textFont(menuFont);
  textInit();

  restaurants = loadTable("Restaurant-Inspections.csv", "header");
  violations = loadTable("vermincodes.csv", "header");

  // for matching the violation dates from the restaurant database to the ones in the violation database
  SimpleDateFormat restDate = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss'Z'");
  SimpleDateFormat violStartDate = new SimpleDateFormat("MM-dd-yyyy");
  SimpleDateFormat violEndDate = new SimpleDateFormat("MM-dd-yyyy");
  SimpleDateFormat recentYears = new SimpleDateFormat("MM-dd-yyyy");


  // To check for recent violations, we need to turn the beginning of recent times into an epoch number.
  try {
    isRecent = recentYears.parse(checkRecent);
  }
  catch (Exception e) {
    println("Error parsing recent date: " + e);
  }
  // float recentEpoch = isRecent.getTime();


  // initialize and fill restaurant data
  for (TableRow row : restaurants.rows()) {
    Restaurants r = new Restaurants();
    r.name = row.getString("DBA");
    r.violCode = row.getString("VIOLCODE");
    r.grade = row.getString("CURRENTGRADE");
    r.dateString = row.getString("INSPDATE");
    r.boroCode = row.getString("BORO");

    try {
      r.restDate = restDate.parse(r.dateString);
    } 
    catch (Exception e) {
      println("Error parsing date (restaurant): " + e);
    }

    restList.add(r);
  }

  // initialize and fill vilation data
  for (TableRow row : violations.rows()) {
    Violcodes v = new Violcodes();
    v.violation = row.getString("DESC");
    v.violCode = row.getString("CODE");
    v.startDateString = row.getString("STARTDATE");
    v.endDateString = row.getString("ENDDATE");
    // println(startDateString + "    " + endDateString);

    try {
      v.violStartDate = violStartDate.parse(v.startDateString);
    } 
    catch (Exception e) {
      println("Error parsing date (violStart): " + e);
    }

    try {
      v.violEndDate = violEndDate.parse(v.endDateString);
    } 
    catch (Exception e) {
      println("Error parsing date (violEnd): " + e);
    }
    violList.add(v);
  }


  searchAgrade();
  searchBgrade();
  searchCgrade();
  searchGradePending();
  searchManhattan();
  searchQueens();
  searchBrooklyn();
  searchBronx();
  searchSI();
  textInit();
}


void draw() {
  background(0);
  textSense();
}

// Text functions

void textInit() {
  // text height
  int th = height-25;
  // left margin
  int left = 40;
  // spacer for letter grades
  int s = 70;

  //initalize and place all text buttons
  gradeTitle= new textButton("By grade:", left, th);
  gradeAbutton = new textButton("A", left+150, th);
  gradeBbutton = new textButton("B", left+210, th);
  gradeCbutton = new textButton("C", left+270, th);
  gradePbutton = new textButton("Grade Pending", left+330, th);
  boroughTitle = new textButton("By borough:", left+560, th); 
  manhattanbutton = new textButton("Manhattan", left+730, th);
  queensbutton = new textButton("Queens", left+870, th);
  brooklynbutton = new textButton("Brooklyn", left+980, th);
  bronxbutton = new textButton("Bronx", left+1100, th);
  SIbutton = new textButton("SI", left+1190, th);
}


void textSense() {

  gradeTitle.staticWrite();
  boroughTitle.staticWrite();
  gradeAbutton.write();
  gradeBbutton.write();
  gradeCbutton.write();
  gradePbutton.write();
  manhattanbutton.write();
  queensbutton.write();
  brooklynbutton.write();
  bronxbutton.write();
  SIbutton.write();


  // Displaying and hiding appropriate data when grade items are clicked
  if (gradeAbutton.mouse && mouseClicked) {
    println("grade A button working!!");
    dataBools.put("aData", !dataBools.get("aData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "aData") dataBools.put(whatever, false);
    }
  }

  else if (gradeBbutton.mouse && mouseClicked) {
    println("grade B button working!!");
    dataBools.put("bData", !dataBools.get("bData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "bData") dataBools.put(whatever, false);
    }
  }

  else if (gradeCbutton.mouse && mouseClicked) {
    println("grade C button working!!");
    dataBools.put("cData", !dataBools.get("cData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "cData") dataBools.put(whatever, false);
    }
  }
  else if (gradePbutton.mouse && mouseClicked) {
    println("grade Pending button working!!");
    dataBools.put("pendData", !dataBools.get("pendData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "pendData") dataBools.put(whatever, false);
    }
  }
  
  // Displaying and hiding appropriate data if borough items are clicked
  if (manhattanbutton.mouse && mouseClicked) {
    println("manhattan button working!!");
    dataBools.put("manhattanData", !dataBools.get("manhattanData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "manhattanData") dataBools.put(whatever, false);
    }
  }

  else if (queensbutton.mouse && mouseClicked) {
    println("queens button working!!");
    dataBools.put("queensData", !dataBools.get("queensData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "queensData") dataBools.put(whatever, false);
    }
  }

  else if (brooklynbutton.mouse && mouseClicked) {
 println("brooklyn button working!!");
    dataBools.put("brooklynData", !dataBools.get("brooklynData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "brooklynData") dataBools.put(whatever, false);
    }
  }
  else if (bronxbutton.mouse && mouseClicked) {
 println("bronx button working!!");
    dataBools.put("bronxData", !dataBools.get("bronxData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "bronxData") dataBools.put(whatever, false);
    }
  }
  else if (SIbutton.mouse && mouseClicked) {
 println("SI button working!!");
    dataBools.put("SIData", !dataBools.get("SIData"));

    for (Map.Entry me : dataBools.entrySet()) {
      String whatever = (String) me.getKey();
      if (whatever != "SIData") dataBools.put(whatever, false);
    }
  }

  gradeA.displayData("A", "aData");
  gradeB.displayData("B", "bData");
  gradeC.displayData("C", "cData");
  gradeP.displayData("Pending", "pendData");
  manhattan.displayData("Manhattan", "manhattanData");
  queens.displayData("Queens", "queensData");
  brooklyn.displayData("Brooklyn", "brooklynData");
  bronx.displayData("The Bronx", "bronxData");
  SI.displayData("Staten Island", "SIData");

  mouseClicked = false;
  // mouseBufferOK = false;
}



//  // control the "by grade" category
//  if (byGrade.mouse && mouseBufferOK) {
//    // clicking "by grade" while its already active turns its submenu back off
//    if (gradeBool == true) gradeBool = false;
//    // if it's not active already, turn the submenu on
//    else {
//      displayBoolsOff();
//      gradeBool = true;
//    }
//  } 
//
//  else if (byBorough.mouse && mouseBufferOK) {
//    if (boroughBool == true) boroughBool = false;
//    else {
//      displayBoolsOff();
//      boroughBool = true;
//    }
//  }
//
//// if "by grade" was clicked, display the submenu options
//  if (gradeBool) {
//    gradeA.write();
//    gradeB.write();
//    gradeC.write();
//    gradeP.write();
//  }
//
//  else if (boroughBool) {
//    manhattan.write();
//    queens.write();
//    brooklyn.write();
//    bronx.write();
//    SI.write();
//  }
//}
//

void mouseClicked() {
  mouseClicked = true;
}
//
//void displayBoolsOff() {
//  boroughBool = false;
//  gradeBool = false;
//  
//  for (int i = 0; i < displayBools.length; i++) {
//    displayBools[i] = false;
//  }
//}
//
//void gradeBoolsOff() {
//  for (int i = 0; i < gradeBools.length; i++) {
//    gradeBools[i] = false;
//  }
//}
//
//void boroughBoolsOff() {
//  for (int i = 0; i < boroughBools.length; i++) {
//    boroughBools[i] = false;
//  }




// Grade searching functions

void searchAgrade() {
  float violCount = 0;
  float restCount = 0;
  float recentCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("A")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        float recentEpoch = isRecent.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
            if (inspectionTime >= recentEpoch) {
              recentCount++;
            }
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  float recentPercentage = (recentCount/violCount) * 100;
  int cockroachNumber = round(percentage);
  int sizeRatio = round(map(recentPercentage, 0, 100, 0, cockroachNumber));
  gradeA = new Grade((int) restCount, (int) violCount, (int) recentCount, percentage, recentPercentage);
  println("There are " + (int) restCount + " A-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println((int) recentCount + " of these violations occurred within the past year. This is " + recentPercentage + "% of all violations for this group.");
  println(cockroachNumber + " cockroaches should go in this scene. " + sizeRatio + " of them should be large.");
  println();
}

void searchBgrade() {
  float violCount = 0;
  float restCount = 0;
  float recentCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("B")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        float recentEpoch = isRecent.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
            if (inspectionTime >= recentEpoch) {
              recentCount++;
            }
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  float recentPercentage = (recentCount/violCount) * 100;
  int cockroachNumber = round(percentage);
  int sizeRatio = round(map(recentPercentage, 0, 100, 0, cockroachNumber));
  gradeB = new Grade((int) restCount, (int) violCount, (int) recentCount, percentage, recentPercentage);
  println("There are " + (int) restCount + " B-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println((int)recentCount + " of these violations occurred within the past year. This is " + recentPercentage + "% of all violations for this group.");
  println(cockroachNumber + " cockroaches should go in this scene. " + sizeRatio + " of them should be large.");
  println();
}

void searchCgrade() {
  float violCount = 0;
  float restCount = 0;
  float recentCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("C")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        float recentEpoch = isRecent.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
            if (inspectionTime >= recentEpoch) {
              recentCount++;
            }
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  float recentPercentage = (recentCount/violCount) * 100;
  int cockroachNumber = round(percentage);
  int sizeRatio = round(map(recentPercentage, 0, 100, 0, cockroachNumber));
  gradeC = new Grade((int) restCount, (int) violCount, (int) recentCount, percentage, recentPercentage);
  println("There are " + (int) restCount + " C-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println((int) recentCount + " of these violations occurred within the past year. This is " + recentPercentage + "% of all violations for this group.");
  println(cockroachNumber + " cockroaches should go in this scene. " + sizeRatio + " of them should be large.");
  println();
}

void searchGradePending() {
  float violCount = 0;
  float restCount = 0;
  float recentCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("P")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        float recentEpoch = isRecent.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
            if (inspectionTime >= recentEpoch) {
              recentCount++;
            }
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  float recentPercentage = (recentCount/violCount) * 100;
  int cockroachNumber = round(percentage);
  int sizeRatio = round(map(recentPercentage, 0, 100, 0, cockroachNumber));
  gradeP = new Grade((int) restCount, (int) violCount, (int) recentCount, percentage, recentPercentage);
  println("There are " + (int) restCount + " Grade Pending establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println((int) recentCount + " of these violations occurred within the past year. This is " + recentPercentage + "% of all violations for this group.");
  println(cockroachNumber + " cockroaches should go in this scene. " + sizeRatio + " of them should be large.");
  println();
}



// Borough searching functions

void searchManhattan() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.boroCode.equals("1")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  manhattan = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Manhattan and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println();
}

void searchQueens() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.boroCode.equals("4")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  queens = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Queens and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println();
}

void searchBrooklyn() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.boroCode.equals("3")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  brooklyn = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Brooklyn and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println();
}

void searchBronx() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.boroCode.equals("2")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  bronx = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in the Bronx and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println();
}

void searchSI() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.boroCode.equals("5")) {
      restCount++;
      for (Violcodes v: violList) {
        float startRange = v.violStartDate.getTime();
        float endRange = v.violEndDate.getTime();
        if (r.violCode.equals(v.violCode)) {
          if (inspectionTime >= startRange && inspectionTime <= endRange) {
            violCount++;
          }
        }
      }
    }
  }
  float percentage = (violCount/restCount) * 100;
  SI = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Staten Island and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
  println();
}

