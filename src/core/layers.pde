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
  public Target bounds() {
    return mark(BOUNDS);
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
    m.put(BOUNDS, bounds);
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
  
  //= common-operations.pde
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
  //= ../../build/graphics-export.pde
  
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
  public GraphicsLayer image(String file, float x, float y) {
    return image(loadImage(file), x, y);
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
  for (int i=stackables.length; i>0;)
    ret.add(stackables[--i]);
  return ret;
}
public GroupLayer group(Layer... items) {
  GroupLayer ret = new GroupLayer();
  for (int i=items.length; i>0;)
    ret.add(items[--i]);
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
public Render render(Layer l) {
  Render r = l.render().round();
  image(r.image, r.p.x, r.p.y);
  return r;
}
public Render render(Stackable... s) {
  return render(stack(s));
}

// Other constants
public final String BOUNDS = "bounds";



