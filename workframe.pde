///////////////
// WorkFrame //
//   0.0.1   //
///////////////

// Note: don't edit this file directly, instead see
// https://github.com/jmendeth/workframe#hacking




/*********************
 * General utilities *
 *********************/

// Clone images and graphics

public PGraphics cloneGraphics(PImage img, boolean copy) {
  PGraphics ret = createGraphics(img.width, img.height);
  if (copy) ret.set(0,0,img);
  return ret;
}
public PGraphics cloneGraphics(PImage img) {
  return cloneGraphics(img, false);
}

public PImage cloneImage(PImage img, int mode, boolean copy) {
  PImage ret = createImage(img.width, img.height, mode);
  if (copy) ret.set(0,0,img);
  return ret;
}
public PImage cloneImage(PImage img, int mode) {
  return cloneImage(img, mode, false);
}
public PImage cloneImage(PImage img, boolean copy) {
  return cloneImage(img, ARGB, copy);
}
public PImage cloneImage(PImage img) {
  return cloneImage(img, ARGB, false);
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





/**********************
 * High-level effects *
 **********************/





