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



//= common-processors.pde
