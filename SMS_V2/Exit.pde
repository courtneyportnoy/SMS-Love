class Exit {
  float x = width/3 + 600;
  float y = height/3 + 20;
  float w = 60;

  void render() {
    if (popup) {
      ellipseMode(CENTER);
      imageMode(CENTER);
      ellipse(x, y, w, w);
      image(xImg, x, y);
    }
  }

  boolean overX() {
    return (mouseX < x + w/2 && mouseX > x - w/2 && mouseY > y - w/2 && mouseY < y + w/2);
  }

  void mouseClicked() {
    if (overX()) popup = false;
  }
}

