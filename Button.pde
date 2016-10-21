boolean locked = false;

class Button {
  int x, y;
  int size;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;

  void update() {
   if (gameState == 0)
     return;
    if (over())
      currentcolor = highlightcolor;
    else
      currentcolor = basecolor;
  }

  boolean pressed() {
    color aux;
    if (gameState == 0)
      return false;
    if (over) {
      aux = basecolor;
      basecolor = highlightcolor;
      highlightcolor = aux;
      pressed = ! pressed;
      return true;
    } else {
      locked = false;
      return false;
    }
  }

  boolean over() {
    return true;
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height)
      return true;
    else
      return false;
  }

  boolean overCircle(int x, int y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 )
      return true;
    else
      return false;
  }
}

class CircleButton extends Button {
  CircleButton(int ix, int iy, int isize, color icolor, color ihighlight, boolean ipressed) {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    pressed = ipressed;
  }

  boolean over() {
    if ( overCircle(x, y, size) ) {
      over = true;
      return true;
    } else {
      over = false;
      return false;
    }
  }

  void display() {
    pushStyle();
    stroke(255);
    fill(currentcolor);
    ellipse(x, y, size, size);
    popStyle();
  }
}

class RectButton extends Button {
  RectButton(int ix, int iy, int isize, color icolor, color ihighlight, boolean ipressed) {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    pressed = ipressed;
  }

  boolean over() {
    if ( overRect(x, y, size, size) ) {
      over = true;
      return true;
    } else {
      over = false;
      return false;
    }
  }

  void display() {
    pushStyle();
    stroke(255);
    fill(currentcolor);
    rect(x, y, size, size);
    popStyle();
  }
}