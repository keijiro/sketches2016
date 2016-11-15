PImage tex;
float texw;
float texm11, texm12, texm21, texm22;

color PickPixel(float x, float y)
{
  float s = x - 0.5;
  float t = y - 0.5;
  x = texm11 * s + texm12 * t;
  y = texm21 * s + texm22 * t;
  x = (x + 0.5) * texw;
  y = (y + 0.5) * texw;
  return tex.get((int)x, (int)y);
}

void SetMatrix(float phi, float zoom)
{
  float s = 1.0 / zoom;
  texm11 = cos(phi) * s;
  texm12 = -sin(phi) * s;
  texm21 = sin(phi) * s;
  texm22 = cos(phi) * s;
}

void setup()
{
  tex = loadImage("MonaLisa.jpg");
  texw = min(tex.width, tex.height);

  frameRate(24);
  size(500, 500);
  smooth();
  noStroke();
}

void draw()
{
  int res = 32;
  
  float rcpres = 1.0 / res;
  float maxr = width * rcpres / 256;
  
  float t = PI * 2 * frameCount / (3 * 24);
  SetMatrix(t, 2 + sin(t));

  background(0);
  
  for (int iy = 0; iy < res; iy++)
  {
    float y = (iy + 0.5) * rcpres;
    for (int ix = 0; ix < res; ix++)
    {
      float x = (ix + 0.5) * rcpres;
      float r = brightness(PickPixel(x, y)) * maxr;
      ellipse(x * width, y * height, r, r);
    }
  }
  
  if (frameCount <= 3 * 24) saveFrame();
}