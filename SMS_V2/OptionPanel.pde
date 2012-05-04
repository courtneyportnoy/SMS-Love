/***************************************************************************
 
 A class to create an option panel which allows user to select option
 
 ****************************************************************************/

class OptionPanel {
  int w = 247/2;
  int h = 57/2;

  PImage img1;
  PImage img2;
  PImage img3;
  PImage img1_r;
  PImage img2_r;
  PImage img3_r;

  OptionPanel(PImage img1t, PImage img2t, PImage img3t, PImage img11t, PImage img22t, PImage img33t) {
    img1 = img1t;
    img2 = img2t;
    img3 = img3t;
    img1_r = img11t;
    img2_r = img22t;
    img3_r = img33t;
  }

  void display() {
    if (!hidden) {
      imageMode(CENTER);
      image(img1, width/2, height/3);
      image(img2, width/2, 1.5*height/3);
      image(img3, width/2, 2*height/3);
      
      if(overChaos()) image(img1_r, width/2, height/3);
      if(overTimeline()) image(img2_r, width/2, 1.5*height/3);
      if(overSearch()) image(img3_r, width/2, 2*height/3);
    }
  }
  
  boolean overChaos() {
    return (mouseX > width/2 - w && mouseX < width/2 + w && mouseY > height/3 - h && mouseY < height/3 + h);
  }
  boolean overTimeline() {
    return (mouseX > width/2 - w && mouseX < width/2 + w && mouseY > 1.5*height/3 - h && mouseY < 1.5*height/3 + h);
  }
  boolean overSearch() {
    return (mouseX > width/2 - w && mouseX < width/2 + w && mouseY > 2*height/3 - h && mouseY < 2*height/3 + h);
  }

  boolean overButton() {
    if (mouseX < width/2 + w && mouseX > width/2 - w && mouseY < 2 * height/3 + h && mouseY > height/3 - h) {
      return true;
    }
    return false;
  }

  void mouseClicked() {
    if (mouseX > width/2 - w && mouseX < width/2 + w && mouseY > height/3 - h && mouseY < height/3 + h) {
      // do chaos stuff
      chaos = true;
      println("CHAOS");
    }
    else if (mouseX > width/2 - w && mouseX < width/2 + w && mouseY > 1.5*height/3 - h && mouseY < 1.5*height/3 + h) {
      //do timeline stuff
      timeline = true;
      println("TIMELINE");
    }
    else if (mouseX > width/2 - w && mouseX < width/2 + w && mouseY > 2*height/3 - h && mouseY < 2*height/3 + h) {
      // do search stuff
      search = true;
      println("SEARCH");
    }
    hidden = true;
  }
}

