class MessageObject {
  String dateTime;
  String messageText;
  String messageDirection;

  PVector pos = new PVector();
  PVector tpos = new PVector();


  void update() {
    pos.x = lerp(pos.x, tpos.x, 1);
    pos.y = lerp(pos.y, tpos.y, 1);
  }

  void render() {
    pushMatrix();
      stroke(255,0,0);
      fill(0);
      translate(pos.x, pos.y);
      ellipseMode(RADIUS);
      int r = 2;
      //if(messageText.contains("love")){
        image(heart, 5, 5);
        //text(messageText,0,0);
      //}
    popMatrix();
  }
}

