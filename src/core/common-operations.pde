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

public BlenderLayer negMaskAlpha(Layer sec) {
  return blend(negMaskAlphaBlender, sec);
}
public BlenderLayer negMaskAlpha() {
  return blend(negMaskAlphaBlender, null);
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
public EffectLayer fill(float c1) {
  return fill(color(c1));
}
public EffectLayer fill(float c1, float c2) {
  return fill(color(c1,c2));
}
public EffectLayer fill(float c1, float c2, float c3) {
  return fill(color(c1,c2,c3));
}
public EffectLayer fill(float c1, float c2, float c3, float c4) {
  return fill(color(c1,c2,c3,c4));
}

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
