
// Credits:
// Christina Carter helped with clickable text!
// Brenner helped with booleans!
// Val convinced me to keep working on this instead of printing out miniature restaurant bar areas!


import java.util.Date;
import java.text.SimpleDateFormat;

Table restaurants;
Table violations;
ArrayList<Restaurants> restList = new ArrayList();
ArrayList<Violcodes> violList = new ArrayList();

//BufferedReader reader;
//PrintWriter writer;

PFont menuFont;

long lastClickTime = 0;

Grade gradeA, gradeB, gradeC;
textButton gradeTitle, boroughTitle, gradeAbutton, gradeBbutton, gradeCbutton, gradePbutton, manhattanbutton, queensbutton, brooklynbutton, bronxbutton, SIbutton;

boolean gradeBool, boroughBool, aBool, bBool, cBool, pBool, manhattanBool, queensBool, brooklynBool, bronxBool, SIBool;
boolean mouseBufferOK = false;
boolean mouseClicked = false;


// boolean category arrays
boolean[] displayBools= {
  aBool, bBool, cBool, pBool, manhattanBool, queensBool, brooklynBool, bronxBool, SIBool
};
boolean[] gradeBools = {
  aBool, bBool, cBool, pBool
};
boolean[] boroughBools = {
  manhattanBool, queensBool, brooklynBool, bronxBool, SIBool
};

void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth();
  menuFont = createFont("AvenirNext-UltraLight", 24);
  //menuFont = createFont("AvenirNextCondensed-UltraLight", 24);


  textFont(menuFont);
  textInit();

  restaurants = loadTable("Restaurant-Inspections.csv", "header");
  violations = loadTable("vermincodes.csv", "header");

  // for matching the violation dates from the restaurant database to the ones in the violation database
  SimpleDateFormat restDate = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss'Z'");
  SimpleDateFormat violStartDate = new SimpleDateFormat("MM-dd-yyyy");
  SimpleDateFormat violEndDate = new SimpleDateFormat("MM-dd-yyyy");

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

  if (gradeAbutton.mouse && mouseClicked) {
    println("grade A button working!!");
    gradeA.displayData("A");
  }
    else if (gradeBbutton.mouse && mouseClicked) {
    println("grade B button working!!");
  }
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
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("A")) {
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
  gradeA = new Grade((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " A-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

void searchBgrade() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("B")) {
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
  gradeB = new Grade((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " B-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

void searchCgrade() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("C")) {
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
  gradeC = new Grade((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " C-graded establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

void searchGradePending() {
  float violCount = 0;
  float restCount = 0;
  for (Restaurants r: restList) {
    float inspectionTime = r.restDate.getTime();
    if (r.grade.equals("P") || r.grade.equals("Z")) {
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
  Grade gradeP = new Grade((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " Grade Pending establishments and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
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
  Borough manhattan = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Manhattan and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
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
  Borough queens = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Queens and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
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
  Borough brooklyn = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Brooklyn and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
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
  Borough bronx = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in the Bronx and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
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
  Borough SI = new Borough((int) restCount, (int) violCount, percentage);
  println("There are " + (int) restCount + " restaurants in Staten Island and " + (int) violCount + " of them have vermin violations. " + percentage + "% ratio.");
}

