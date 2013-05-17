///////////////
// WorkFrame //
//   0.0.1   //
///////////////

// Note: don't edit this file directly, instead see
// https://github.com/jmendeth/workframe#hacking



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



/********************
 * Geometry classes *
 ********************/

public class Vector2 implements Cloneable {
  public final float x;
  public final float y;
  public Vector2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public Vector2 clone() {
    return this;
  }
  
  // Vectorial operations
  public float mag() {
    return sqrt(x*x + y*y);
  }
  public float magSq() {
    return x*x + y*y;
  }
  public Vector2 perp() {
    return new Vector2(-y,+x);
  }
  public Vector2 nperp() {
    return new Vector2(+y,-x);
  }
  public Vector2 flip() {
    return new Vector2(y,x);
  }
  public float angle() {
    return atan2(y,x);
  }
  
  // Basic operations
  public Vector2 add(Vector2 v) {
    return new Vector2(x+v.x, y+v.y);
  }
  public Vector2 mul(float n) {
    return new Vector2(x*n, y*n);
  }
  public Vector2 div(float n) {
    return new Vector2(x/n, y/n);
  }
  public Vector2 abs() {
    return new Vector2(__abs(x), __abs(y));
  }
  
  // Inverse operations
  public Vector2 neg() {
    return mul(-1);
  }
  
  // Compound basic operations
  public Vector2 sub(Vector2 v) {
    return add(v.neg());
  }
  public Vector2 rsub(Vector2 v) {
    return neg().add(v);
  }
  
  // Compound vectorial operations
  public Vector2 mul(float nx, float ny) {
    return new Vector2(x*nx, y*ny);
  }
  public Vector2 mag(float m) {
    return mul(m/mag());
  }
  public Vector2 magOf(float m) {
    return mul(1 + m/mag());
  }
  public Vector2 angle(float a) {
    float m = mag();
    a += angle();
    return new Vector2(cos(a)*m, sin(a)*m);
  }
  public Vector2 rotate(float a) {
    //FIXME: Better way to rotate a vector?
    return angle(angle()+a);
  }
  public Vector2 round() {
    return new Vector2(__round(x), __round(y));
  }
  public Vector2 roundUp() {
    return new Vector2(__roundUp(x), __roundUp(y));
  }
  public Vector2 roundDown() {
    return new Vector2(__roundDown(x), __roundDown(y));
  }
  
  // Classes
  public Point2 add(Point2 p) {
    return p.add(this);
  }
}

public class Point2 extends Vector2 implements Target {
  public Point2(float x, float y) {
    super(x,y);
  }
  public Point2(Vector2 v) {
    super(v.x, v.y);
  }
  public Point2 add(Vector2 v) {
    return new Point2(x+v.x, y+v.y);
  }
  public Point2 sub(Vector2 v) {
    return new Point2(x-v.x, y-v.y);
  }
  public Point2 scale(Point2 pivot, float n) {
    return sub(pivot).mul(n).add(pivot);
  }
  public Point2 scale(Point2 pivot, float nx, float ny) {
    return sub(pivot).mul(nx,ny).add(pivot);
  }
  public Point2 rotate(Point2 pivot, float a) {
    return sub(pivot).rotate(a).add(pivot);
  }
  public Point2 mid(Point2 p) {
    return new Point2((x+p.x)/2, (y+p.y)/2);
  }
  public Point2 round() {
    return new Point2(__round(x), __round(y));
  }
  public Point2 roundUp() {
    return new Point2(__roundUp(x), __roundUp(y));
  }
  public Point2 roundDown() {
    return new Point2(__roundDown(x), __roundDown(y));
  }
  
  // see Target at other.pde
  public Rectangle2 getTarget() {
    return rectangle(this);
  }
}

public class Rectangle2 implements Cloneable, Target {
  public final Point2 p;
  public final Vector2 dim;
  public Rectangle2(Point2 p, Vector2 dim) {
    this.p = p;
    this.dim = dim;
  }
  public Rectangle2 clone() {
    return this;
  }
  // see Target at other.pde
  public Rectangle2 getTarget() {
    return this;
  }
  public Rectangle2 add(Vector2 v) {
    return new Rectangle2(p.add(v), dim);
  }
  public Rectangle2 sub(Vector2 v) {
    return new Rectangle2(p.sub(v), dim);
  }
  public Rectangle2 scale(Point2 pivot, float nx, float ny) {
    Point2 np = p.scale(pivot, nx, ny);
    Vector2 ndim = corner().scale(pivot, nx, ny).sub(p);
    return new Rectangle2(np, ndim);
  }
  public Rectangle2 scale(Point2 pivot, float n) {
    return scale(pivot, n, n);
  }
  public Rectangle2 scale(float nx, float ny) {
    return scale(mid(), nx, ny);
  }
  public Rectangle2 scale(float n) {
    return scale(mid(), n);
  }
  public Point2 mid() {
    return p.add(dim.div(2));
  }
  public Point2 lrp(float x, float y) {
    float nx = p.x + dim.x*x;
    float ny = p.y + dim.y*y;
    return coord(nx, ny);
  }
  public Rectangle2 round() {
    Point2 c = corner();
    int px = __roundDown(p.x);
    int py = __roundDown(p.y);
    int cx = __roundUp(c.x);
    int cy = __roundUp(c.y);
    Point2 np = coord(px, py);
    Point2 nc = coord(cx, cy);
    return new Rectangle2(np, nc.sub(np));
  }
  public Rectangle2 norm() {
    if (dim.x < 0 || dim.y < 0)
      return new Rectangle2(corner(), p);
    return this;
  }
  public Rectangle2 pad(float l, float u, float r, float d) {
    Vector2 offset = vector(-l,-u);
    Vector2 augment = vector(l+r,u+d);
    return new Rectangle2(p.add(offset), dim.add(augment));
  }
  public Rectangle2 pad(float u, float h, float d) {
    return pad(h,u,h,d);
  }
  public Rectangle2 pad(float h, float v) {
    return pad(h,v,h,v);
  }
  public Rectangle2 pad(float r) {
    return pad(r,r,r,r);
  }
  public Point2 corner() {
    return p.add(dim);
  }
  public Point2[] points() {
    Point2[] ret = new Point2[4];
    ret[0] = p;
    ret[1] = p.add(vector(dim.x,0));
    ret[2] = p.add(vector(0,dim.y));
    ret[3] = p.add(dim); //aka corner()
    return ret;
  }
  public Rectangle2 merge(Rectangle2... rects) {
    float px = p.x;
    float py = p.y;
    float cx = p.x+dim.x;
    float cy = p.y+dim.y;
    for (Rectangle2 r : rects) {
      float rpx = r.p.x;
      float rpy = r.p.y;
      float rcx = r.p.x+r.dim.x;
      float rcy = r.p.y+r.dim.y;
      if (px>rpx) px=rpx;
      if (py>rpy) py=rpy;
      if (cx<rcx) cx=rcx;
      if (cy<rcy) cy=rcy;
    }
    return new Rectangle2(coord(px,py), vector(cx-px,cy-py));
  }
  //FIXME: add intersect()
}

// Some shortcuts
public Point2 coord(float x, float y) {
  return new Point2(x,y);
}
public Point2 coord(Vector2 v) {
  return new Point2(v);
}
public Vector2 vector(float x, float y) {
  return new Vector2(x,y);
}
public Vector2 vector(Point2 from, Point2 to) {
  return to.sub(from);
}
public Vector2 vector(PImage img) {
  return new Vector2(img.width, img.height);
}
public Rectangle2 rectangle(Point2 p, Vector2 dim) {
  return new Rectangle2(p, dim);
}
public Rectangle2 rectangle(Point2 p, PImage dim) {
  return new Rectangle2(p, vector(dim));
}
public Rectangle2 rectangle(float x, float y, float width, float height) {
  return new Rectangle2(new Point2(x,y), new Vector2(width, height));
}
public Rectangle2 rectangle(Point2 p) {
  return new Rectangle2(p, new Vector2(0,0));
}
public Rectangle2 rectangle(float x, float y) {
  return rectangle(coord(x,y));
}

public final Point2 ORIG = coord(0,0);



/*****************
 * Other classes *
 *****************/

// Stores the result of calling render() on a Layer
public class Render implements Cloneable {
  public final Point2 p;
  public final PImage image;
  public final HashMap marks;

  public Render(Point2 p, PImage image, HashMap marks) {
    this.p = p;
    this.image = image;
    this.marks = marks;
  }
  public Render(Point2 p, PImage image) {
    this(p, image, new HashMap());
  }

  public Render clone() {
    return this;
  }
  public Rectangle2 bounds() {
    return rectangle(p, image);
  }
  public Rectangle2 mark(String name) {
    return (Rectangle2)(marks.get(name));
  }
  public Render move(Vector2 offset) {
    HashMap m = new HashMap(marks);
    for (Object k : m.keySet()) { //TODO: test
      Rectangle2 v = (Rectangle2)m.get(k);
      m.put(k, v.add(offset));
    }
    return new Render(p.add(offset), image, m);
  }
  public Render moveTo(Point2 loc) {
    return move(loc.sub(p));
  }
  public Render round() {
    Point2 loc = p.round();
    Vector2 offset = loc.sub(p);
    return move(offset);
  }
}
public final Render EMPTY = new Render(coord(0,0), newImage(1,1));

// "Points to" a mark
public interface Target {
  public Rectangle2 getTarget();
}

public class MarkTarget implements Target {
  public final Layer target;
  public final String mark;
  public MarkTarget(Layer target, String mark) {
    this.target = target;
    this.mark = mark;
  }
  public Rectangle2 getTarget() {
    return target.render().mark(mark);
  }
}

// Anything that can be added to a StackLayer
public interface Stackable {
  public BlenderLayer[] getStackables();
}



/**************
 * Processors *
 **************/

// EFFECT processor (takes one input)
public interface Effect {
  public Render apply(Render input);
}

public abstract class PixelEffect implements Effect {
  public abstract color process(color input);
  public Render apply(Render input) {
    PImage im = input.image;
    PImage ret = newImage(im);
    im.loadPixels();
    ret.loadPixels();
    
    int l = im.width*im.height;
    for (int i=0; i<l; i++)
      ret.pixels[i] = process(im.pixels[i]);
    
    ret.updatePixels();
    return new Render(input.p, ret, input.marks);
  }
}

public class NullEffect implements Effect {
  public Render apply(Render input) {
    return input;
  }
}

// BLENDER processor (takes two inputs)
public interface Blender {
  public Render apply(Render base, Render sec);
}

public abstract class GenericBlender implements Blender {
  public abstract Render applyTo(Render base, Render sec);
  public Render apply(Render base, Render sec) {
    // Reposition renders
    base = base.round();
    sec = sec.round();
    // Calculate merged bounds
    Rectangle2 bounds = base.bounds().merge(sec.bounds());
    // Create images
    PImage baseI = newImage(bounds.dim);
    PImage secI = newImage(bounds.dim);
    // Draw into them
    Point2 loc;
    loc = base.p.sub(bounds.p);
    baseI.set((int)loc.x, (int)loc.y, base.image);
    loc = sec.p.sub(bounds.p);
    secI.set((int)loc.x, (int)loc.y, sec.image);
    // Call!
    return applyTo( new Render(bounds.p, baseI, base.marks)
                  , new Render(bounds.p,  secI,  sec.marks) );
  }
  public /*static*/ HashMap mergeMarks(Render base, Render sec) {
    HashMap ret = new HashMap();
    ret.putAll(sec.marks);
    ret.putAll(base.marks);
    return ret;
  }
}

public abstract class PixelBlender extends GenericBlender {
  public abstract color process(color base, color sec);
  public Render applyTo(Render base, Render sec) {
    // Prepare
    PImage b = base.image;
    PImage s = sec.image;
    PImage ret = newImage(b);
    b.loadPixels();
    s.loadPixels();
    ret.loadPixels();
    
    // Process!
    int l = b.width*b.height;
    for (int i=0; i<l; i++)
      ret.pixels[i] = process(b.pixels[i], s.pixels[i]);
    
    // Finish
    ret.updatePixels();
    return new Render(base.p, ret, mergeMarks(base,sec));
  }
}



/*********************
 * Common processors *
 *********************/

// LAYER POSITIONING

public class MoveEffect implements Effect {
  public final Vector2 offset;
  public MoveEffect(Vector2 offset) {
    this.offset = offset;
  }
  public Render apply(Render r) {
    return r.move(offset);
  }
}

public class AlignEffect implements Effect {
  public final String ref;
  public final float x;
  public final float y;
  public final Target t;
  public AlignEffect(String ref, float x, float y, Target t) {
    this.ref = ref;
    this.x = x;
    this.y = y;
    this.t = t;
  }
  public Render apply(Render r) {
    float sx = alignToStd(x);
    float sy = alignToStd(y);
    Point2 rm = r.mark(ref).lrp(sx,sy);
    Point2 tm = t.getTarget().lrp(sx,sy);
    return r.move(tm.sub(rm));
  }
}


// LAYER CROPPING & PADDING

public class CropEffect implements Effect {
  public final Target t;
  public CropEffect(Target t) {
    this.t = t;
  }
  public Render apply(Render r) {
    Rectangle2 tm = t.getTarget();
    PImage ret = newImage(tm.dim);
    Point2 loc = r.p.sub(tm.p).round();
    r = r.moveTo(loc.add(tm.p));
    ret.set((int)loc.x, (int)loc.y, r.image);
    return new Render(tm.p, ret, r.marks);
  }
}

public class PadEffect implements Effect {
  public final float l;
  public final float u;
  public final float r;
  public final float d;
  public PadEffect(float l, float u, float r, float d) {
    this.l = l;
    this.u = u;
    this.r = r;
    this.d = d;
  }
  public Render apply(Render re) {
    Rectangle2 tm = re.bounds().pad(l,u,r,d);
    PImage ret = newImage(tm.dim);
    Point2 loc = re.p.sub(tm.p).round();
    re = re.moveTo(loc.add(tm.p));
    ret.set((int)loc.x, (int)loc.y, re.image);
    return new Render(tm.p, ret, re.marks);
  }
}


// LAYER SCALING
//TODO


// LAYER MIRRORING
//TODO


// LAYER ROTATING
//TODO


// ALPHA OPERATIONS

//// ALPHA = 1
PixelEffect removeAlphaEffect = new PixelEffect() {
  public color process(color pixel) {
    return acolor(ared(pixel),agreen(pixel),ablue(pixel),255);
  }
};

//// ALPHA = 1
//// RED = alpha
//// GREEN = alpha
//// BLUE = alpha
PixelEffect extractAlphaEffect = new PixelEffect() {
  public color process(color pixel) {
    float a = aalpha(pixel);
    return acolor(a,a,a);
  }
};

//// VALUE = 0
//// ALPHA = blue
PixelEffect toAlphaEffect = new PixelEffect() {
  public color process(color pixel) {
    return acolor(0,0,0,ablue(pixel));
  }
};

//// ALPHA = alpha2
PixelBlender setAlphaBlender = new PixelBlender() {
  public color process(color pixel, color other) {
    return acolor(ared(pixel),agreen(pixel),ablue(pixel),aalpha(other));
  }
};

//// ALPHA = alpha*alpha2
PixelBlender maskAlphaBlender = new PixelBlender() {
  public color process(color pixel, color other) {
    return acolor(ared(pixel),agreen(pixel),ablue(pixel), aalpha(pixel)*aalpha(other)/255);
  }
};

//// ALPHA = blue2
PixelBlender setToAlphaBlender = new PixelBlender() {
  public color process(color pixel, color other) {
    return acolor(ared(pixel),agreen(pixel),ablue(pixel), ablue(other));
  }
};


// GENERAL COLOR OPERATIONS

Effect cleanEffect = new Effect() {
  public Render apply(Render r) {
    return new Render(r.p, newImage(r.image));
  }
};

//// RED = 1-red
//// GREEN = 1-green
//// BLUE = 1-blue
PixelEffect invertEffect = new PixelEffect() {
  public color process(color pixel) {
    return acolor(255-ared(pixel), 255-agreen(pixel), 255-ablue(pixel), aalpha(pixel));
  }
};

//// ALPHA = 1-alpha
PixelEffect invertAlphaEffect = new PixelEffect() {
  public color process(color pixel) {
    return acolor(ared(pixel),agreen(pixel),ablue(pixel), 255-aalpha(pixel));
  }
};

//// RED = fillRed
//// GREEN = fillGreen
//// BLUE = fillBlue
//// ALPHA = fillAlpha*alpha
public class FillEffect extends PixelEffect {
  public final color fill;
  public FillEffect(color fill) {
    this.fill = fill;
  }
  public color process(color pixel) {
    return acolor(ared(fill), agreen(fill), ablue(fill), aalpha(fill)*aalpha(pixel)/255);
  }
}

//// ALPHA = opacity*alpha
public class OpacityEffect extends PixelEffect {
  public final float opacity;
  public OpacityEffect(float opacity) {
    this.opacity = opacity;
  }
  public color process(color pixel) {
    return acolor(ared(pixel), agreen(pixel), ablue(pixel), aalpha(pixel)*opacity);
  }
}

//TODO: LevelsEffect

// NATIVE OPERATIONS

//// blend()
public class BlendBlender extends GenericBlender {
  public final int mode;
  public BlendBlender(int mode) {
    this.mode = mode;
  }
  public Render applyTo(Render base, Render sec) {
    PImage ret = cloneImage(base.image);
    int w = ret.width;
    int h = ret.height;
    ret.blend(sec.image, 0,0, w,h, 0,0, w,h, mode);
    return new Render(base.p, ret, mergeMarks(base,sec));
  }
}

//// self blend()
public class BlendEffect implements Effect {
  public final int mode;
  public final int times;
  public BlendEffect(int mode, int times) {
    this.mode = mode;
    this.times = times;
  }
  public Render apply(Render r) {
    PImage ret = cloneImage(r.image);
    int w = ret.width;
    int h = ret.height;
    for (int i=0; i<times; i++)
      ret.blend(0,0, w,h, 0,0, w,h, mode);
    return new Render(r.p, ret, r.marks);
  }
}

//// filter()
public class FilterEffect implements Effect {
  public final int kind;
  public final Float param;
  public FilterEffect(int kind, Float param) {
    this.kind = kind;
    this.param = param;
  }
  public FilterEffect(int kind) {
    this(kind, null);
  }
  public Render apply(Render r) {
    PImage ret = cloneImage(r.image);
    if (param == null) ret.filter(kind);
    else ret.filter(kind, param);
    return new Render(r.p, ret, r.marks);
  }
}

//// tint()
//TODO

//// filter() with shader
//TODO



/*****************
 * The Layer API *
 *****************/

public abstract class Layer implements Cloneable {
  // Marking & naming (should be overloaded)
  private final HashMap marks = new HashMap();
  private String name_ = null;
  public Layer mark(String s, Rectangle2 m) {
    marks.put(s, m);
    return this;
  }
  public Layer mark(String s, float x, float y, float w, float h) {
    marks.put(s, rectangle(x,y,w,h));
    return this;
  }
  public Layer mark(String s, float x, float y) {
    marks.put(s, rectangle(x,y,0,0));
    return this;
  }
  public Layer unmark(String s) {
    marks.put(s, null);
    return this;
  }
  public Layer name(String name) {
    name_ = name;
    return this;
  }
  public Layer unname() {
    return name(null);
  }
  public String name() {
    return name_;
  }
  public Target mark(String s) {
    return new MarkTarget(this, s);
  }
  
  // Cloning and copying
  //TODO: cloning, copying
  
  // Rendering
  abstract protected Render doRender();
  public Render render() {
    Render r = doRender();
    Rectangle2 bounds = r.bounds();
    HashMap m = new HashMap(r.marks);
    m.putAll(marks);
    m.put(name_, bounds);
    m.put("bounds", bounds);
    return new Render(r.p, r.image, m);
  }
  public ImageLayer raster() {
    return new ImageLayer(render());
  }
  
  // Generic blending operations
  public BlenderLayer blend(Blender b, Layer sec) {
    return new BlenderLayer(b, this, sec);
  }
  public BlenderLayer blend(Blender b) {
    return blend(b, null);
  }
  public BlenderLayer rblend(Blender b, Layer base) {
    return new BlenderLayer(b, base, this);
  }
  public BlenderLayer rblend(Blender b) {
    return rblend(b, null);
  }
  
  // Generic effect operations
  public EffectLayer effect(Effect e) {
    return new EffectLayer(e, this);
  }
  
  // Positioning operations
  
  public EffectLayer move(Vector2 offset) {
    return effect(new MoveEffect(offset));
  }
  public EffectLayer move(float offsetX, float offsetY) {
    return move(vector(offsetX,offsetY));
  }
  
  public EffectLayer align(String ref, float x, float y, Target target) {
    return effect(new AlignEffect(ref,x,y,target));
  }
  public EffectLayer align(String ref, float x, float y, float targetX, float targetY) {
    return align(ref,x,y,rectangle(targetX,targetY,0,0));
  }
  public EffectLayer align(String ref, float x, float y) {
    return align(ref,x,y,TBOUNDS);
  }
  
  public EffectLayer align(float x, float y, Target target) {
    return align(BOUNDS,x,y,target);
  }
  public EffectLayer align(float x, float y, float targetX, float targetY) {
    return align(BOUNDS,x,y,targetX,targetY);
  }
  public EffectLayer align(float x, float y) {
    return align(BOUNDS,x,y);
  }
  
  public EffectLayer center(String ref, Target target) {
    return align(ref,0,0,target);
  }
  public EffectLayer center(String ref, float targetX, float targetY) {
    return align(ref,0,0,targetX,targetY);
  }
  public EffectLayer center(String ref) {
    return align(ref,0,0);
  }
  
  public EffectLayer center(Target target) {
    return center(BOUNDS,target);
  }
  public EffectLayer center(float targetX, float targetY) {
    return center(BOUNDS,targetX,targetY);
  }
  public EffectLayer center() {
    return center(BOUNDS);
  }
  
  // Cropping & Padding operations
  
  public EffectLayer crop(Target t) {
    return effect(new CropEffect(t));
  }
  public EffectLayer crop(String t) {
    return crop(mark(t));
  }
  public EffectLayer crop() {
    return crop(rectangle());
  }
  
  public EffectLayer pad(float l, float u, float r, float d) {
    return effect(new PadEffect(l,u,r,d));
  }
  public EffectLayer pad(float u, float h, float d) {
    return pad(h,u,h,d);
  }
  public EffectLayer pad(float v, float h) {
    return pad(h,v,h,v);
  }
  public EffectLayer pad(float p) {
    return pad(p,p,p,p);
  }
  
  // Alpha operations
  
  public EffectLayer removeAlpha() {
    return effect(removeAlphaEffect);
  }
  
  public EffectLayer extractAlpha() {
    return effect(extractAlphaEffect);
  }
  
  public EffectLayer toAlpha() {
    return effect(toAlphaEffect);
  }
  
  public BlenderLayer setAlpha(Layer sec) {
    return blend(setAlphaBlender, sec);
  }
  public BlenderLayer setAlpha() {
    return blend(setAlphaBlender, null);
  }
  
  public BlenderLayer maskAlpha(Layer sec) {
    return blend(maskAlphaBlender, sec);
  }
  public BlenderLayer maskAlpha() {
    return blend(maskAlphaBlender, null);
  }
  
  public BlenderLayer setToAlpha(Layer sec) {
    return blend(setToAlphaBlender, sec);
  }
  public BlenderLayer setToAlpha() {
    return blend(setToAlphaBlender, null);
  }
  
  // General color operations
  
  public EffectLayer clean() {
    return effect(cleanEffect);
  }
  
  public EffectLayer invert() {
    return effect(invertEffect);
  }
  
  public EffectLayer invertAlpha() {
    return effect(invertAlphaEffect);
  }
  
  public EffectLayer fill(color fill) {
    return effect(new FillEffect(fill));
  }
  //FIXME: other color shortcuts
  
  public EffectLayer opacity(float opacity) {
    return effect(new OpacityEffect(opacity));
  }
  
  // Native operations: blend
  
  public BlenderLayer blend(int mode, Layer sec) {
    return blend(new BlendBlender(mode), sec);
  }
  public BlenderLayer rblend(int mode, Layer base) {
    return rblend(new BlendBlender(mode), base);
  }
  public BlenderLayer blend(int mode) {
    return blend(mode, null);
  }
  public BlenderLayer rblend(int mode) {
    return rblend(mode, null);
  }
  
  public BlenderLayer blend(Layer sec) {
    return blend(BLEND, sec);
  }
  public BlenderLayer rblend(Layer base) {
    return rblend(BLEND, base);
  }
  public BlenderLayer blend() {
    return blend(BLEND);
  }
  public BlenderLayer rblend() {
    return rblend(BLEND);
  }
  
  // Other native operations
  
  public EffectLayer filter(int kind, float param) {
    return effect(new FilterEffect(kind, param));
  }
  public EffectLayer filter(int kind) {
    return effect(new FilterEffect(kind));
  }
  
  // Shortcuts to common filters
  
  public EffectLayer blur(float radius) {
    return pad(roundUp(radius)).filter(BLUR, radius);
  }
  
  //TODO: implement selfblend
  //TODO: implement missing processors and their operations
  //TODO: implement autocrop
}


public class ImageLayer extends Layer {
  private final Render r;
  public ImageLayer(Render r) {
    this.r = r;
  }
  protected Render doRender() {
    return r;
  }
  public ImageLayer raster() {
    return this;
  }
}


public class GraphicsLayer extends Layer {
  public final PGraphics g;
  public final int width;
  public final int height;
  private boolean open = true;
  public GraphicsLayer(PGraphics g) {
    this.g = g;
    g.beginDraw();
    width = g.width;
    height = g.height;
  }
  // We never overload constructors, but we do that here
  // because these constructors are user-facing, in case
  // he wants to implement `draw`.
  public GraphicsLayer(float width, float height) {
    this(newGraphics(width,height));
  }
  public GraphicsLayer(Vector2 dim) {
    this(newGraphics(dim));
  }
  public GraphicsLayer() {
    this(newGraphics(__width(),__height()));
  }
  void draw() {} //FIXME: experiment with permissions
  protected Render doRender() {
    if (open) {
      draw();
      g.endDraw();
      open = false;
    }
    return new Render(coord(0,0), g);
  }
  public Rectangle2 bounds() {
    return rectangle(0,0,width,height);
  }
  
  // Export methods
  public float alpha(int rgb) {
    return g.alpha(rgb);
  }
  public GraphicsLayer ambient(float gray) {
    g.ambient(gray);
    return this;
  }
  public GraphicsLayer ambient(float v1, float v2, float v3) {
    g.ambient(v1, v2, v3);
    return this;
  }
  public GraphicsLayer ambient(int rgb) {
    g.ambient(rgb);
    return this;
  }
  public GraphicsLayer ambientLight(float v1, float v2, float v3) {
    g.ambientLight(v1, v2, v3);
    return this;
  }
  public GraphicsLayer ambientLight(float v1, float v2, float v3, float x, float y, float z) {
    g.ambientLight(v1, v2, v3, x, y, z);
    return this;
  }
  public GraphicsLayer applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
    g.applyMatrix(n00, n01, n02, n10, n11, n12);
    return this;
  }
  public GraphicsLayer applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
    g.applyMatrix(n00, n01, n02, n03, n10, n11, n12, n13, n20, n21, n22, n23, n30, n31, n32, n33);
    return this;
  }
  public GraphicsLayer applyMatrix(PMatrix source) {
    g.applyMatrix(source);
    return this;
  }
  public GraphicsLayer applyMatrix(PMatrix2D source) {
    g.applyMatrix(source);
    return this;
  }
  public GraphicsLayer applyMatrix(PMatrix3D source) {
    g.applyMatrix(source);
    return this;
  }
  public GraphicsLayer arc(float a, float b, float c, float d, float start, float stop) {
    g.arc(a, b, c, d, start, stop);
    return this;
  }
  public GraphicsLayer arc(float a, float b, float c, float d, float start, float stop, int mode) {
    g.arc(a, b, c, d, start, stop, mode);
    return this;
  }
  public GraphicsLayer background(float gray) {
    g.background(gray);
    return this;
  }
  public GraphicsLayer bg(float gray) {
    g.background(gray);
    return this;
  }
  public GraphicsLayer background(float gray, float alpha) {
    g.background(gray, alpha);
    return this;
  }
  public GraphicsLayer bg(float gray, float alpha) {
    g.background(gray, alpha);
    return this;
  }
  public GraphicsLayer background(float v1, float v2, float v3) {
    g.background(v1, v2, v3);
    return this;
  }
  public GraphicsLayer bg(float v1, float v2, float v3) {
    g.background(v1, v2, v3);
    return this;
  }
  public GraphicsLayer background(float v1, float v2, float v3, float alpha) {
    g.background(v1, v2, v3, alpha);
    return this;
  }
  public GraphicsLayer bg(float v1, float v2, float v3, float alpha) {
    g.background(v1, v2, v3, alpha);
    return this;
  }
  public GraphicsLayer background(int rgb) {
    g.background(rgb);
    return this;
  }
  public GraphicsLayer bg(int rgb) {
    g.background(rgb);
    return this;
  }
  public GraphicsLayer background(int rgb, float alpha) {
    g.background(rgb, alpha);
    return this;
  }
  public GraphicsLayer bg(int rgb, float alpha) {
    g.background(rgb, alpha);
    return this;
  }
  public GraphicsLayer background(PImage image) {
    g.background(image);
    return this;
  }
  public GraphicsLayer bg(PImage image) {
    g.background(image);
    return this;
  }
  public GraphicsLayer beginCamera() {
    g.beginCamera();
    return this;
  }
  public GraphicsLayer beginContour() {
    g.beginContour();
    return this;
  }
  public GraphicsLayer beginDraw() {
    g.beginDraw();
    return this;
  }
  public PGL beginPGL() {
    return g.beginPGL();
  }
  public GraphicsLayer beginRaw(PGraphics rawGraphics) {
    g.beginRaw(rawGraphics);
    return this;
  }
  public GraphicsLayer beginShape() {
    g.beginShape();
    return this;
  }
  public GraphicsLayer beginShape(int kind) {
    g.beginShape(kind);
    return this;
  }
  public GraphicsLayer bezier(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    g.bezier(x1, y1, x2, y2, x3, y3, x4, y4);
    return this;
  }
  public GraphicsLayer bezier(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
    g.bezier(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4);
    return this;
  }
  public GraphicsLayer bezierDetail(int detail) {
    g.bezierDetail(detail);
    return this;
  }
  public float bezierPoint(float a, float b, float c, float d, float t) {
    return g.bezierPoint(a, b, c, d, t);
  }
  public float bezierTangent(float a, float b, float c, float d, float t) {
    return g.bezierTangent(a, b, c, d, t);
  }
  public GraphicsLayer bezierVertex(float x2, float y2, float x3, float y3, float x4, float y4) {
    g.bezierVertex(x2, y2, x3, y3, x4, y4);
    return this;
  }
  public GraphicsLayer bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
    g.bezierVertex(x2, y2, z2, x3, y3, z3, x4, y4, z4);
    return this;
  }
  public GraphicsLayer blendMode(int mode) {
    g.blendMode(mode);
    return this;
  }
  public float blue(int rgb) {
    return g.blue(rgb);
  }
  public GraphicsLayer box(float size) {
    g.box(size);
    return this;
  }
  public GraphicsLayer box(float w, float h, float d) {
    g.box(w, h, d);
    return this;
  }
  public float brightness(int rgb) {
    return g.brightness(rgb);
  }
  public GraphicsLayer camera() {
    g.camera();
    return this;
  }
  public GraphicsLayer camera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
    g.camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
    return this;
  }
  public boolean canDraw() {
    return g.canDraw();
  }
  public GraphicsLayer clip(float a, float b, float c, float d) {
    g.clip(a, b, c, d);
    return this;
  }
  public GraphicsLayer colorMode(int mode) {
    g.colorMode(mode);
    return this;
  }
  public GraphicsLayer colorMode(int mode, float max) {
    g.colorMode(mode, max);
    return this;
  }
  public GraphicsLayer colorMode(int mode, float max1, float max2, float max3) {
    g.colorMode(mode, max1, max2, max3);
    return this;
  }
  public GraphicsLayer colorMode(int mode, float max1, float max2, float max3, float maxA) {
    g.colorMode(mode, max1, max2, max3, maxA);
    return this;
  }
  public PShape createShape() {
    return g.createShape();
  }
  public PShape createShape(int type) {
    return g.createShape(type);
  }
  public PShape createShape(int kind, float... p) {
    return g.createShape(kind, p);
  }
  public PShape createShape(PShape source) {
    return g.createShape(source);
  }
  public GraphicsLayer curve(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    g.curve(x1, y1, x2, y2, x3, y3, x4, y4);
    return this;
  }
  public GraphicsLayer curve(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
    g.curve(x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4);
    return this;
  }
  public GraphicsLayer curveDetail(int detail) {
    g.curveDetail(detail);
    return this;
  }
  public float curvePoint(float a, float b, float c, float d, float t) {
    return g.curvePoint(a, b, c, d, t);
  }
  public float curveTangent(float a, float b, float c, float d, float t) {
    return g.curveTangent(a, b, c, d, t);
  }
  public GraphicsLayer curveTightness(float tightness) {
    g.curveTightness(tightness);
    return this;
  }
  public GraphicsLayer curveVertex(float x, float y) {
    g.curveVertex(x, y);
    return this;
  }
  public GraphicsLayer curveVertex(float x, float y, float z) {
    g.curveVertex(x, y, z);
    return this;
  }
  public GraphicsLayer directionalLight(float v1, float v2, float v3, float nx, float ny, float nz) {
    g.directionalLight(v1, v2, v3, nx, ny, nz);
    return this;
  }
  public boolean displayable() {
    return g.displayable();
  }
  public GraphicsLayer dispose() {
    g.dispose();
    return this;
  }
  public GraphicsLayer edge(boolean edge) {
    g.edge(edge);
    return this;
  }
  public GraphicsLayer ellipse(float a, float b, float c, float d) {
    g.ellipse(a, b, c, d);
    return this;
  }
  public GraphicsLayer ellipseMode(int mode) {
    g.ellipseMode(mode);
    return this;
  }
  public GraphicsLayer emissive(float gray) {
    g.emissive(gray);
    return this;
  }
  public GraphicsLayer emissive(float v1, float v2, float v3) {
    g.emissive(v1, v2, v3);
    return this;
  }
  public GraphicsLayer emissive(int rgb) {
    g.emissive(rgb);
    return this;
  }
  public GraphicsLayer endCamera() {
    g.endCamera();
    return this;
  }
  public GraphicsLayer endContour() {
    g.endContour();
    return this;
  }
  public GraphicsLayer endDraw() {
    g.endDraw();
    return this;
  }
  public GraphicsLayer endPGL() {
    g.endPGL();
    return this;
  }
  public GraphicsLayer endRaw() {
    g.endRaw();
    return this;
  }
  public GraphicsLayer endShape() {
    g.endShape();
    return this;
  }
  public GraphicsLayer endShape(int mode) {
    g.endShape(mode);
    return this;
  }
  public GraphicsLayer fg(float gray) {
    g.fill(gray);
    return this;
  }
  public GraphicsLayer fg(float gray, float alpha) {
    g.fill(gray, alpha);
    return this;
  }
  public GraphicsLayer fg(float v1, float v2, float v3) {
    g.fill(v1, v2, v3);
    return this;
  }
  public GraphicsLayer fg(float v1, float v2, float v3, float alpha) {
    g.fill(v1, v2, v3, alpha);
    return this;
  }
  public GraphicsLayer fg(int rgb) {
    g.fill(rgb);
    return this;
  }
  public GraphicsLayer fg(int rgb, float alpha) {
    g.fill(rgb, alpha);
    return this;
  }
  public GraphicsLayer flush() {
    g.flush();
    return this;
  }
  public GraphicsLayer frustum(float left, float right, float bottom, float top, float near, float far) {
    g.frustum(left, right, bottom, top, near, far);
    return this;
  }
  public java.lang.Object getCache(PImage image) {
    return g.getCache(image);
  }
  public PMatrix getMatrix() {
    return g.getMatrix();
  }
  public PMatrix2D getMatrix(PMatrix2D target) {
    return g.getMatrix(target);
  }
  public PMatrix3D getMatrix(PMatrix3D target) {
    return g.getMatrix(target);
  }
  public PGraphics getRaw() {
    return g.getRaw();
  }
  public PStyle getStyle() {
    return g.getStyle();
  }
  public PStyle getStyle(PStyle s) {
    return g.getStyle(s);
  }
  public float green(int rgb) {
    return g.green(rgb);
  }
  public boolean haveRaw() {
    return g.haveRaw();
  }
  public GraphicsLayer hint(int which) {
    g.hint(which);
    return this;
  }
  public float hue(int rgb) {
    return g.hue(rgb);
  }
  public GraphicsLayer image(PImage img, float a, float b) {
    g.image(img, a, b);
    return this;
  }
  public GraphicsLayer image(PImage img, float a, float b, float c, float d) {
    g.image(img, a, b, c, d);
    return this;
  }
  public GraphicsLayer image(PImage img, float a, float b, float c, float d, int u1, int v1, int u2, int v2) {
    g.image(img, a, b, c, d, u1, v1, u2, v2);
    return this;
  }
  public GraphicsLayer imageMode(int mode) {
    g.imageMode(mode);
    return this;
  }
  public java.lang.Object initCache(PImage img) {
    return g.initCache(img);
  }
  public boolean is2D() {
    return g.is2D();
  }
  public boolean is3D() {
    return g.is3D();
  }
  public boolean isGL() {
    return g.isGL();
  }
  public int lerpColor(int c1, int c2, float amt) {
    return g.lerpColor(c1, c2, amt);
  }
  public GraphicsLayer lightFalloff(float constant, float linear, float quadratic) {
    g.lightFalloff(constant, linear, quadratic);
    return this;
  }
  public GraphicsLayer lights() {
    g.lights();
    return this;
  }
  public GraphicsLayer lightSpecular(float v1, float v2, float v3) {
    g.lightSpecular(v1, v2, v3);
    return this;
  }
  public GraphicsLayer line(float x1, float y1, float x2, float y2) {
    g.line(x1, y1, x2, y2);
    return this;
  }
  public GraphicsLayer line(float x1, float y1, float z1, float x2, float y2, float z2) {
    g.line(x1, y1, z1, x2, y2, z2);
    return this;
  }
  public PShader loadShader(java.lang.String fragFilename) {
    return g.loadShader(fragFilename);
  }
  public PShader loadShader(java.lang.String fragFilename, java.lang.String vertFilename) {
    return g.loadShader(fragFilename, vertFilename);
  }
  public PShape loadShape(java.lang.String filename) {
    return g.loadShape(filename);
  }
  public float modelX(float x, float y, float z) {
    return g.modelX(x, y, z);
  }
  public float modelY(float x, float y, float z) {
    return g.modelY(x, y, z);
  }
  public float modelZ(float x, float y, float z) {
    return g.modelZ(x, y, z);
  }
  public GraphicsLayer noClip() {
    g.noClip();
    return this;
  }
  public GraphicsLayer noFill() {
    g.noFill();
    return this;
  }
  public GraphicsLayer noLights() {
    g.noLights();
    return this;
  }
  public GraphicsLayer normal(float nx, float ny, float nz) {
    g.normal(nx, ny, nz);
    return this;
  }
  public GraphicsLayer noSmooth() {
    g.noSmooth();
    return this;
  }
  public GraphicsLayer noStroke() {
    g.noStroke();
    return this;
  }
  public GraphicsLayer noTexture() {
    g.noTexture();
    return this;
  }
  public GraphicsLayer noTint() {
    g.noTint();
    return this;
  }
  public GraphicsLayer ortho() {
    g.ortho();
    return this;
  }
  public GraphicsLayer ortho(float left, float right, float bottom, float top) {
    g.ortho(left, right, bottom, top);
    return this;
  }
  public GraphicsLayer ortho(float left, float right, float bottom, float top, float near, float far) {
    g.ortho(left, right, bottom, top, near, far);
    return this;
  }
  public GraphicsLayer perspective() {
    g.perspective();
    return this;
  }
  public GraphicsLayer perspective(float fovy, float aspect, float zNear, float zFar) {
    g.perspective(fovy, aspect, zNear, zFar);
    return this;
  }
  public GraphicsLayer point(float x, float y) {
    g.point(x, y);
    return this;
  }
  public GraphicsLayer point(float x, float y, float z) {
    g.point(x, y, z);
    return this;
  }
  public GraphicsLayer pointLight(float v1, float v2, float v3, float x, float y, float z) {
    g.pointLight(v1, v2, v3, x, y, z);
    return this;
  }
  public GraphicsLayer popMatrix() {
    g.popMatrix();
    return this;
  }
  public GraphicsLayer popStyle() {
    g.popStyle();
    return this;
  }
  public GraphicsLayer printCamera() {
    g.printCamera();
    return this;
  }
  public GraphicsLayer printMatrix() {
    g.printMatrix();
    return this;
  }
  public GraphicsLayer printProjection() {
    g.printProjection();
    return this;
  }
  public GraphicsLayer pushMatrix() {
    g.pushMatrix();
    return this;
  }
  public GraphicsLayer pushStyle() {
    g.pushStyle();
    return this;
  }
  public GraphicsLayer quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    g.quad(x1, y1, x2, y2, x3, y3, x4, y4);
    return this;
  }
  public GraphicsLayer quadraticVertex(float cx, float cy, float x3, float y3) {
    g.quadraticVertex(cx, cy, x3, y3);
    return this;
  }
  public GraphicsLayer quadraticVertex(float cx, float cy, float cz, float x3, float y3, float z3) {
    g.quadraticVertex(cx, cy, cz, x3, y3, z3);
    return this;
  }
  public GraphicsLayer rect(float a, float b, float c, float d) {
    g.rect(a, b, c, d);
    return this;
  }
  public GraphicsLayer rect(float a, float b, float c, float d, float r) {
    g.rect(a, b, c, d, r);
    return this;
  }
  public GraphicsLayer rect(float a, float b, float c, float d, float tl, float tr, float br, float bl) {
    g.rect(a, b, c, d, tl, tr, br, bl);
    return this;
  }
  public GraphicsLayer rectMode(int mode) {
    g.rectMode(mode);
    return this;
  }
  public float red(int rgb) {
    return g.red(rgb);
  }
  public GraphicsLayer removeCache(PImage image) {
    g.removeCache(image);
    return this;
  }
  public GraphicsLayer requestDraw() {
    g.requestDraw();
    return this;
  }
  public GraphicsLayer resetMatrix() {
    g.resetMatrix();
    return this;
  }
  public GraphicsLayer resetShader() {
    g.resetShader();
    return this;
  }
  public GraphicsLayer resetShader(int kind) {
    g.resetShader(kind);
    return this;
  }
  public GraphicsLayer rotateX(float angle) {
    g.rotateX(angle);
    return this;
  }
  public GraphicsLayer rotateY(float angle) {
    g.rotateY(angle);
    return this;
  }
  public GraphicsLayer rotateZ(float angle) {
    g.rotateZ(angle);
    return this;
  }
  public float saturation(int rgb) {
    return g.saturation(rgb);
  }
  public float screenX(float x, float y) {
    return g.screenX(x, y);
  }
  public float screenX(float x, float y, float z) {
    return g.screenX(x, y, z);
  }
  public float screenY(float x, float y) {
    return g.screenY(x, y);
  }
  public float screenY(float x, float y, float z) {
    return g.screenY(x, y, z);
  }
  public float screenZ(float x, float y, float z) {
    return g.screenZ(x, y, z);
  }
  public GraphicsLayer setCache(PImage image, java.lang.Object storage) {
    g.setCache(image, storage);
    return this;
  }
  public GraphicsLayer setFrameRate(float frameRate) {
    g.setFrameRate(frameRate);
    return this;
  }
  public GraphicsLayer setMatrix(PMatrix source) {
    g.setMatrix(source);
    return this;
  }
  public GraphicsLayer setMatrix(PMatrix2D source) {
    g.setMatrix(source);
    return this;
  }
  public GraphicsLayer setMatrix(PMatrix3D source) {
    g.setMatrix(source);
    return this;
  }
  public GraphicsLayer setParent(PApplet parent) {
    g.setParent(parent);
    return this;
  }
  public GraphicsLayer setPath(java.lang.String path) {
    g.setPath(path);
    return this;
  }
  public GraphicsLayer setPrimary(boolean primary) {
    g.setPrimary(primary);
    return this;
  }
  public GraphicsLayer setSize(int w, int h) {
    g.setSize(w, h);
    return this;
  }
  public GraphicsLayer shader(PShader shader) {
    g.shader(shader);
    return this;
  }
  public GraphicsLayer shader(PShader shader, int kind) {
    g.shader(shader, kind);
    return this;
  }
  public GraphicsLayer shape(PShape shape) {
    g.shape(shape);
    return this;
  }
  public GraphicsLayer shape(PShape shape, float x, float y) {
    g.shape(shape, x, y);
    return this;
  }
  public GraphicsLayer shape(PShape shape, float a, float b, float c, float d) {
    g.shape(shape, a, b, c, d);
    return this;
  }
  public GraphicsLayer shapeMode(int mode) {
    g.shapeMode(mode);
    return this;
  }
  public GraphicsLayer shearX(float angle) {
    g.shearX(angle);
    return this;
  }
  public GraphicsLayer shearY(float angle) {
    g.shearY(angle);
    return this;
  }
  public GraphicsLayer shininess(float shine) {
    g.shininess(shine);
    return this;
  }
  public GraphicsLayer smooth() {
    g.smooth();
    return this;
  }
  public GraphicsLayer smooth(int level) {
    g.smooth(level);
    return this;
  }
  public GraphicsLayer specular(float gray) {
    g.specular(gray);
    return this;
  }
  public GraphicsLayer specular(float v1, float v2, float v3) {
    g.specular(v1, v2, v3);
    return this;
  }
  public GraphicsLayer specular(int rgb) {
    g.specular(rgb);
    return this;
  }
  public GraphicsLayer sphere(float r) {
    g.sphere(r);
    return this;
  }
  public GraphicsLayer sphereDetail(int res) {
    g.sphereDetail(res);
    return this;
  }
  public GraphicsLayer sphereDetail(int ures, int vres) {
    g.sphereDetail(ures, vres);
    return this;
  }
  public GraphicsLayer spotLight(float v1, float v2, float v3, float x, float y, float z, float nx, float ny, float nz, float angle, float concentration) {
    g.spotLight(v1, v2, v3, x, y, z, nx, ny, nz, angle, concentration);
    return this;
  }
  public GraphicsLayer stroke(float gray) {
    g.stroke(gray);
    return this;
  }
  public GraphicsLayer stroke(float gray, float alpha) {
    g.stroke(gray, alpha);
    return this;
  }
  public GraphicsLayer stroke(float v1, float v2, float v3) {
    g.stroke(v1, v2, v3);
    return this;
  }
  public GraphicsLayer stroke(float v1, float v2, float v3, float alpha) {
    g.stroke(v1, v2, v3, alpha);
    return this;
  }
  public GraphicsLayer stroke(int rgb) {
    g.stroke(rgb);
    return this;
  }
  public GraphicsLayer stroke(int rgb, float alpha) {
    g.stroke(rgb, alpha);
    return this;
  }
  public GraphicsLayer strokeCap(int cap) {
    g.strokeCap(cap);
    return this;
  }
  public GraphicsLayer strokeJoin(int join) {
    g.strokeJoin(join);
    return this;
  }
  public GraphicsLayer strokeWeight(float weight) {
    g.strokeWeight(weight);
    return this;
  }
  public GraphicsLayer style(PStyle s) {
    g.style(s);
    return this;
  }
  public GraphicsLayer text(char[] chars, int start, int stop, float x, float y) {
    g.text(chars, start, stop, x, y);
    return this;
  }
  public GraphicsLayer text(char[] chars, int start, int stop, float x, float y, float z) {
    g.text(chars, start, stop, x, y, z);
    return this;
  }
  public GraphicsLayer text(char c, float x, float y) {
    g.text(c, x, y);
    return this;
  }
  public GraphicsLayer text(char c, float x, float y, float z) {
    g.text(c, x, y, z);
    return this;
  }
  public GraphicsLayer text(float num, float x, float y) {
    g.text(num, x, y);
    return this;
  }
  public GraphicsLayer text(float num, float x, float y, float z) {
    g.text(num, x, y, z);
    return this;
  }
  public GraphicsLayer text(int num, float x, float y) {
    g.text(num, x, y);
    return this;
  }
  public GraphicsLayer text(int num, float x, float y, float z) {
    g.text(num, x, y, z);
    return this;
  }
  public GraphicsLayer text(java.lang.String str, float x, float y) {
    g.text(str, x, y);
    return this;
  }
  public GraphicsLayer text(java.lang.String str, float x, float y, float z) {
    g.text(str, x, y, z);
    return this;
  }
  public GraphicsLayer text(java.lang.String str, float x1, float y1, float x2, float y2) {
    g.text(str, x1, y1, x2, y2);
    return this;
  }
  public GraphicsLayer textAlign(int alignX) {
    g.textAlign(alignX);
    return this;
  }
  public GraphicsLayer align(int alignX) {
    g.textAlign(alignX);
    return this;
  }
  public GraphicsLayer textAlign(int alignX, int alignY) {
    g.textAlign(alignX, alignY);
    return this;
  }
  public GraphicsLayer align(int alignX, int alignY) {
    g.textAlign(alignX, alignY);
    return this;
  }
  public float textAscent() {
    return g.textAscent();
  }
  public float textDescent() {
    return g.textDescent();
  }
  public GraphicsLayer textFont(PFont which) {
    g.textFont(which);
    return this;
  }
  public GraphicsLayer textFont(PFont which, float size) {
    g.textFont(which, size);
    return this;
  }
  public GraphicsLayer textLeading(float leading) {
    g.textLeading(leading);
    return this;
  }
  public GraphicsLayer textMode(int mode) {
    g.textMode(mode);
    return this;
  }
  public GraphicsLayer textSize(float size) {
    g.textSize(size);
    return this;
  }
  public GraphicsLayer texture(PImage image) {
    g.texture(image);
    return this;
  }
  public GraphicsLayer textureMode(int mode) {
    g.textureMode(mode);
    return this;
  }
  public GraphicsLayer textureWrap(int wrap) {
    g.textureWrap(wrap);
    return this;
  }
  public float textWidth(char c) {
    return g.textWidth(c);
  }
  public float textWidth(char[] chars, int start, int length) {
    return g.textWidth(chars, start, length);
  }
  public float textWidth(java.lang.String str) {
    return g.textWidth(str);
  }
  public GraphicsLayer translate(float x, float y) {
    g.translate(x, y);
    return this;
  }
  public GraphicsLayer translate(float x, float y, float z) {
    g.translate(x, y, z);
    return this;
  }
  public GraphicsLayer triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    g.triangle(x1, y1, x2, y2, x3, y3);
    return this;
  }
  public GraphicsLayer vertex(float[] v) {
    g.vertex(v);
    return this;
  }
  public GraphicsLayer vertex(float x, float y) {
    g.vertex(x, y);
    return this;
  }
  public GraphicsLayer vertex(float x, float y, float z) {
    g.vertex(x, y, z);
    return this;
  }
  public GraphicsLayer vertex(float x, float y, float u, float v) {
    g.vertex(x, y, u, v);
    return this;
  }
  public GraphicsLayer vertex(float x, float y, float z, float u, float v) {
    g.vertex(x, y, z, u, v);
    return this;
  }
  
  // Use geometry
  public GraphicsLayer ellipse(Rectangle2 r) {
    return ellipse(r.p.x, r.p.y, r.dim.x, r.dim.y);
  }
  public GraphicsLayer rect(Rectangle2 r) {
    return rect(r.p.x, r.p.y, r.dim.x, r.dim.y);
  }
  public GraphicsLayer rect(Rectangle2 r, float radius) {
    return rect(r.p.x, r.p.y, r.dim.x, r.dim.y, radius);
  }
  public GraphicsLayer rect(Rectangle2 r, float tl, float tr, float br, float bl) {
    return rect(r.p.x, r.p.y, r.dim.x, r.dim.y, tl, tr, br, bl);
  }
  public GraphicsLayer circle(Point2 p, float radius) {
    return circle(p.x, p.y, radius);
  }
  public GraphicsLayer line(Point2 p1, Point2 p2) {
    return line(p1.x, p1.y, p2.x, p2.y);
  }
  
  // Other shortcuts
  public GraphicsLayer circle(float x, float y, float radius) {
    return ellipse(x,y,radius,radius);
  }
  public GraphicsLayer font(String name, float size) {
    return textFont(createFont(name, size, true), size);
  }
}


public class EffectLayer extends Layer {
  private final Effect e;
  private Layer l;
  public EffectLayer(Effect e, Layer l) {
    this.e = e;
    this.l = l;
  }
  public Effect proc() {
    return e;
  }
  public EffectLayer to(Layer l) {
    this.l = l;
    return this;
  }
  public Layer to() {
    return l;
  }
  protected Render doRender() {
    return e.apply(l.render());
  }
}


public class Placeholder extends EffectLayer {
  public Placeholder(Layer l) {
    super(new NullEffect(), l);
  }
}


public class BlenderLayer extends Layer implements Stackable {
  private final Blender b;
  private Layer base_;
  private Layer sec_;
  public BlenderLayer(Blender b, Layer base, Layer sec) {
    this.b = b;
    base_ = base;
    sec_ = sec;
  }
  public Blender proc() {
    return b;
  }
  public BlenderLayer base(Layer base) {
    base_ = base;
    return this;
  }
  public Layer base() {
    return base_;
  }
  public BlenderLayer sec(Layer sec) {
    sec_ = sec;
    return this;
  }
  public Layer sec() {
    return sec_;
  }
  public BlenderLayer[] getStackables() {
    return new BlenderLayer[]{copy()};
  }
  protected Render doRender() {
    return b.apply(base_.render(), sec_.render());
  }
  public BlenderLayer copy() {
    return new BlenderLayer(b, base_, sec_);
  }
}


public class StackLayer extends Layer implements Stackable {
  private final ArrayList list = new ArrayList();
  //TODO: export add(stackable), remove(layer), indexOf, size, clear, has(layer), get(int), set, add(int, stackable), empty
  protected Render doRender() {
    int l = size();
    if (l==0) throw new RuntimeException("No items to merge!"); //FIXME: use custom log mechanism
    Render ret = blendFirst();
    for (int i=1; i<l; i++) {
      BlenderLayer bl = (BlenderLayer)list.get(i);
      ret = bl.proc().apply(ret,bl.base().render());
    }
    return ret;
  }
  private Render blendFirst() {
    BlenderLayer bl = (BlenderLayer)list.get(0);
    Render i = bl.base().render();
    Render c = new Render(i.p, newImage(i.image), i.marks);
    return bl.proc().apply(c, i);
  }
  public BlenderLayer[] getStackables() {
    int l = size();
    BlenderLayer[] ret = new BlenderLayer[l];
    for (int i=0; i<l; i++)
      ret[i] = ((BlenderLayer)list.get(i)).copy();
    return ret;
  }
  public StackLayer add(Stackable s) {
    BlenderLayer[] t = s.getStackables();
    for (int i=0; i<t.length; i++) list.add(t[i]);
    return this;
  }
  public StackLayer add(int idx, Stackable s) {
    BlenderLayer[] t = s.getStackables();
    for (int i=0; i<t.length; i++) list.add(idx+i, t[i]);
    return this;
  }
  
  // General list methods
  public boolean empty() {
    return list.isEmpty();
  }
  public int size() {
    return list.size();
  }
  public StackLayer clear() {
    list.clear();
    return this;
  }
  // Index-based list methods
  public Layer get(int i) {
    return ((BlenderLayer)list.get(i)).base();
  }
  public int indexOf(Layer l) {
    int len = size();
    for (int i=0; i<len; i++) {
      BlenderLayer bl = ((BlenderLayer)list.get(i));
      if (bl.base() == l) return i;
    }
    return -1;
  }
  public StackLayer set(int i, Layer nl) {
    ((BlenderLayer)list.get(i)).base(nl);
    return this;
  }
  public StackLayer set(int i, Blender nb) {
    list.set(i, get(i).blend(nb));
    return this;
  }
  public Blender proc(int i) {
    return ((BlenderLayer)list.get(i)).proc();
  }
  public StackLayer remove(int i) {
    list.remove(i);
    return this;
  }
  
  // Layer-based list methods
  public StackLayer set(Layer l, Layer nl) {
    return set(indexOf(l), nl);
  }
  public StackLayer set(Layer l, Blender nb) {
    return set(indexOf(l), nb);
  }
  public Blender proc(Layer l) {
    return proc(indexOf(l));
  }
  public StackLayer replace(BlenderLayer bl) {
    return set(bl.base(), bl.proc());
  }
  public StackLayer remove(Layer l) {
    return remove(indexOf(l));
  }
  public boolean has(Layer l) {
    return indexOf(l) != -1;
  }
}


public class GroupLayer extends Layer implements Stackable {
  private final ArrayList items = new ArrayList();
  protected Render doRender() {
    int l = items.size();
    if (l==0) throw new RuntimeException("No items to merge!"); //FIXME: use custom log mechanism
    Blender b = new BlendBlender(BLEND);
    Render ret = ((Layer)(items.get(0))).render();
    for (int i=1; i<l; i++)
      ret = b.apply(ret, ((Layer)(items.get(i))).render());
    return ret;
  }
  public BlenderLayer[] getStackables() {
    int l = size();
    BlenderLayer[] ret = new BlenderLayer[l];
    for (int i=0; i<l; i++)
      ret[i] = ((Layer)get(i)).blend();
    return ret;
  }
  // List manipulation
  public GroupLayer add(Layer l) {
    items.add(l);
    return this;
  }
  public GroupLayer remove(Layer l) {
    items.remove(l);
    return this;
  }
  public GroupLayer add(int pos, Layer l) {
    items.add(pos, l);
    return this;
  }
  public GroupLayer set(int pos, Layer l) {
    items.set(pos, l);
    return this;
  }
  public Layer get(int pos) {
    return (Layer)items.get(pos);
  }
  public Layer remove(int pos) {
    items.remove(pos);
    return this;
  }
  public int size() {
    return items.size();
  }
  public int indexOf(Layer t) {
    return items.indexOf(t);
  }
  public GroupLayer clear() {
    items.clear();
    return this;
  }
  public boolean has(Layer l) {
    return items.contains(l);
  }
  public boolean empty() {
    return items.isEmpty();
  }
}


// Layer wrapping shortcuts
public ImageLayer layer(PImage img) {
  return new ImageLayer(new Render(coord(0,0), img));
}
public ImageLayer layer(String s) {
  return layer(loadImage(s));
}
public ImageLayer layer(Render r) {
  return new ImageLayer(r);
}

// Graphics shortcuts
public GraphicsLayer graphics(PGraphics g) {
  return new GraphicsLayer(g);
}
public GraphicsLayer graphics(float width, float height) {
  return new GraphicsLayer(width, height);
}
public GraphicsLayer graphics(Vector2 dim) {
  return new GraphicsLayer(dim);
}
public GraphicsLayer graphics() {
  return new GraphicsLayer();
}

// Stacking & grouping shortcuts
public StackLayer stack(Stackable... stackables) {
  StackLayer ret = new StackLayer();
  for (int i=0; i<stackables.length; i++)
    ret.add(stackables[i]);
  return ret;
}
public GroupLayer group(Layer... items) {
  GroupLayer ret = new GroupLayer();
  for (int i=0; i<items.length; i++)
    ret.add(items[i]);
  return ret;
}

// Placeholding shortcuts
public Placeholder holder(Layer l) {
  return new Placeholder(l);
}
public Placeholder holder() {
  return new Placeholder(null);
}

// Rendering shortcuts
public void render(Layer l) {
  Render r = l.render().round();
  image(r.image, r.p.x, r.p.y);
}
public void render(Stackable... s) {
  render(stack(s));
}

// Other constants
public final String BOUNDS = "bounds";



/**********************
 * High-level effects *
 **********************/

//TODO:shadows
//TODO:gradients


