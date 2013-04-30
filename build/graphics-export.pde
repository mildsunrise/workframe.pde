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
