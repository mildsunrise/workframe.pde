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

public class Point2 extends Vector2 {
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
      if (px<rpx) px=rpx;
      if (px<rpx) py=rpy;
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



