/*********************
 * General utilities *
 *********************/

// Clone an image
public PImage cloneImage(PImage i) {
  try {
    return (PImage)i.clone();
  } catch (CloneNotSupportedException e) {
    throw new RuntimeException(e);
  }
}

// Create images and graphics

public PGraphics newGraphics(float width, float height) {//FIXME: is this okay?
  return createGraphics(roundUp(width), roundUp(height));
}
public PGraphics newGraphics(PImage img, boolean copy) {
  PGraphics ret = createGraphics(img.width, img.height);
  if (copy) ret.set(0,0,img);
  return ret;
}
public PGraphics newGraphics(PImage img) {
  return newGraphics(img, false);
}

public PImage newImage(float width, float height) {
  return createImage(roundUp(width), roundUp(height), ARGB);
}
public PImage newImage(PImage img, int mode, boolean copy) {
  PImage ret = createImage(img.width, img.height, mode);
  if (copy) ret.set(0,0,img);
  return ret;
}
public PImage newImage(PImage img, int mode) {
  return newImage(img, mode, false);
}
public PImage newImage(PImage img, boolean copy) {
  return newImage(img, ARGB, copy);
}
public PImage newImage(PImage img) {
  return newImage(img, ARGB, false);
}

// see core/geometry.pde
public PImage newImage(Vector2 dim) {
  return newImage(dim.x, dim.y);
}
public PGraphics newGraphics(Vector2 dim) {
  return newGraphics(dim.x, dim.y);
}
public Rectangle2 rectangle() {
  return rectangle(0,0,width,height);
}
public Target TBOUNDS = new Target() {
  public Rectangle2 getTarget() {
    return rectangle();
  }
};


// More specific utilities

public int roundUp(float x) {
  int ret = (int)x;
  if (ret<x) return ret+1;
  return ret;
}
public int roundDown(float x) {
  int ret = (int)x;
  if (ret>x) return ret-1;
  return ret;
}
public float alignToStd(float align) {
  return (align+1) / 2;
}
public float stdToAlign(float std) {
  return std*2 - 1;
}

public float lrp(float from, float to, float amt) {
  return from + (to-from)*amt;
}
public Point2 lrp(Point2 from, Point2 to, float amt) {
  return from.add(to.sub(from).mul(amt));
}


// Namespacing

public float __abs(float x) {
  if (x<0) return -x;
  return x;
}
public int __round(float x) {
  return round(x);
}
public int __roundUp(float x) {
  return roundUp(x);
}
public int __roundDown(float x) {
  return roundDown(x);
}

public int __width() {
  return width;
}
public int __height() {
  return height;
}


// Color constants

public final color TRANSPARENT = color(0,0);

public final color BLACK = color(0);
public final color WHITE = color(255);

public final color GRAY  = color(127);

public final color RED   = color(255,0,0);
public final color GREEN = color(0,255,0);
public final color BLUE  = color(0,0,255);

public final color CIAN    = color(0,255,255);
public final color MAGENTA = color(255,0,255);
public final color YELLOW  = color(255,255,0);

// Absolute color components

public float aalpha(color c) { return c >> 8*3 & 0xFF; }
public float ared(color c)   { return c >> 8*2 & 0xFF; }
public float agreen(color c) { return c >> 8*1 & 0xFF; }
public float ablue(color c)  { return c >> 8*0 & 0xFF; }

public color acolor(float red, float green, float blue, float alpha) {
  int r = constrain(round(red  ), 0,255);
  int g = constrain(round(green), 0,255);
  int b = constrain(round(blue ), 0,255);
  int a = constrain(round(alpha), 0,255);

  return  a << 8*3
       |  r << 8*2
       |  g << 8*1
       |  b << 8*0
       ;
}
public color acolor(float red, float green, float blue) {
  return acolor(red,green,blue,255);
}
public color acolor(float value, float alpha) {
  return acolor(value,value,value,alpha);
}
public color acolor(float value) {
  return acolor(value,value,value,255);
}



