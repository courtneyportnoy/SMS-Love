/****************************************************************************
    This class creates a button icon which allows the user to select if they
    are a known user or a guest (encrypt or don't encrypt the data).
****************************************************************************/

class UserButton {
  float x; //x location
  float y; //y location
  float w; //width
  float h; //height
  
  //boolean to determine if the mouse is over the button
  boolean overButton = false;
  
  PImage img;
  PImage imgr;

  UserButton(PImage img1, PImage img2, float tempX, float tempY, float tempW, float tempH) {
    img = img1;
    imgr = img2;
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }
  
  //---------DRAW BACKGROUND & BUTTON----------------
  void display() {
   // background(0);
    imageMode(CENTER);
    image(img, x, y, w, h);
  }
  
  //check to see if mouse is over button
  void hover() {
    if(mouseX > x-w/2 && mouseX < x + w/2 && mouseY > y-h/2 && mouseY < y + h/2) {
      overButton = true;
      image(imgr, x, y, w, h); // this is button's 'over' state
    } else {
      overButton = false;
    }
  }
  
  boolean mouseClicked() {
    if(overButton) {
       on = !on;
       return true;
    } else {
      return false;
    }
  }  
} 
