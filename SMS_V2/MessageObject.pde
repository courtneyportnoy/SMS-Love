class MessageObject {
  String messageText;
  String messageDirection;
  String dateString;
  Date theDate;
  color c;
  float s = 2; //min/max speed
  float r; //size of hearts
  
  float birthtime = 0;

  boolean clicked = false;
  boolean weekend = false;
  PVector speed = new PVector(random(-s, s), random(-s, s));
  PVector pos = new PVector(-100,0);
  PVector tpos = new PVector();

  void update() {

    //initialize location on screen
    pos.x = lerp(pos.x, tpos.x, 0.1);
    pos.y = lerp(pos.y, tpos.y, 0.1);

    //map size of heart to length of text message
    float l = messageText.length();
    r = map(l, 0, 100, 2, 20);
  }
  
  void updateTimeline() {
    
    if(birthtime < globalTime) {
      pos.x = lerp(pos.x, tpos.x, 0.1);
      pos.y = lerp(pos.y, tpos.y, 0.1);
    }
    //map size of heart to length of text message
    float l = messageText.length();
    r = map(l, 0, 100, 2, 20);
  }

  //move hearts around
  void wiggle() {
    tpos.x += speed.x; // Increment x
    tpos.y += speed.y; // Increment y

      // Check horizontal edges
    if (tpos.x > boundary.x || tpos.x < 0) {
      speed.x *= - 1;
    }
    //Check vertical edges
    if (tpos.y > boundary.y || tpos.y < 0) {
      speed.y *= - 1;
    }
  }

  // render hearts onscreen
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (messageDirection.contains("in")) image(heart, 0, 0, r, r);
    if (messageDirection.contains("out")) image(redheart, 0, 0, r, r);
    popMatrix();
  }

  // is the mouse over the heart?
  boolean mouseOver() {
    return (mouseX > pos.x - r && mouseX < pos.x + r && mouseY < pos.y + r && mouseY > pos.y - r);
  }

  void mouseClicked() {
    if (mouseOver()) {
      clicked = true;
      popup = true;
    }
  }
}

