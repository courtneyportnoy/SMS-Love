/***************************************************************************
 
 A class to create a RESET Button which appears while sketch is running.
 
 ****************************************************************************/

class Reset {
  float bx = 10;
  float by = 10;  
  float bw = 55;
  float bh = 55;

  Reset() {
  }

  void display() {
    imageMode(CORNER);
    //rect(bx, by, bw, bh);
    image(bb, bx, by);
    if (overButton()) {
      fill(100);
      noStroke();
      rect(bx+7, by+55, bw-14, 4);
    } 
    else {
      fill(255);
    }
  }

  boolean overButton() {
    return ((mouseX > bx - bw) && (mouseX < bx + bw)
      && (mouseY > by - bh) && (mouseY < by + bh)) ;
  }

  void mouseClicked() {    
    if (overButton()) {      
      on = !on; 
      reset();
    }
  }
}

