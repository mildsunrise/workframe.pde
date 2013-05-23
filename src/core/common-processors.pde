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

//// ALPHA = (1-alpha)*alpha2
PixelBlender negMaskAlphaBlender = new PixelBlender() {
  public color process(color pixel, color other) {
    return acolor(ared(pixel),agreen(pixel),ablue(pixel), (255-aalpha(pixel))*aalpha(other)/255);
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



