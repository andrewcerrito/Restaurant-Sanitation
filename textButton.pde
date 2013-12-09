class textButton {
  String text;
  float textWidth;
  PVector pos = new PVector();
  int x;
  int y;
  color sensedColor =color(255, 159, 3);
  boolean mouse = false;
  boolean wasClicked;

  textButton(String t_text, int t_x, int t_y) {
    text = t_text;
    textWidth = textWidth(text);
    x = t_x;
    y = t_y;
    pos.x = x;
    pos.y = y;
  }

//for interactive text
  void write() { 
    pushMatrix();
    pushStyle();
    //    noFill();
    // rect(pos.x,(pos.y-30),textWidth,30);
    if (mouseX > pos.x && mouseX < (pos.x + textWidth) && mouseY > (pos.y-30) && mouseY < pos.y) {
      mouse = true;
      fill(sensedColor);
    }
    else {
      mouse = false;
      fill(160);
    }
    text(text, pos.x, pos.y);
    popMatrix();
    popStyle();
  }
  
  //for non-interactive text
  void staticWrite(){
    fill(255);
    text(text, pos.x,pos.y);
  }
  
  int giveWidth() {
   int textW = (int) textWidth(text);
    return(textW);
  }
  
}

