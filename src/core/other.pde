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



