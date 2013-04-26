/*********************
 * General utilities *
 *********************/

// Clone images and graphics

public PGraphics newGraphics(PImage img, boolean copy) {
  PGraphics ret = createGraphics(img.width, img.height);
  if (copy) ret.set(0,0,img);
  return ret;
}
public PGraphics newGraphics(PImage img) {
  return cloneGraphics(img, false);
}

public PImage newImage(PImage img, int mode, boolean copy) {
  PImage ret = createImage(img.width, img.height, mode);
  if (copy) ret.set(0,0,img);
  return ret;
}
public PImage newImage(PImage img, int mode) {
  return cloneImage(img, mode, false);
}
public PImage newImage(PImage img, boolean copy) {
  return cloneImage(img, ARGB, copy);
}
public PImage newImage(PImage img) {
  return cloneImage(img, ARGB, false);
}

// see core/geometry.pde
public PImage newImage(Vector2 dim) {
  return createImage(dim.x, dim.y);
}

// More specific utilities

class Utils {
  public static PImage pad(PImage img, int u, int r, int d, int l) {
    PImage ret = createImage( r+img.width +l
                            , u+img.height+d );
    ret.set(r, u, img);
    return ret;
  }
}



