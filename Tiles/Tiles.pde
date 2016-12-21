void setup()
{
  size(512, 512, P2D);
  colorMode(HSB, 1);
}

void draw()
{
  int totalFrames = 96;
  float time = (1.0 / totalFrames * frameCount) % 1;

  int fnum = (frameCount - 1) % totalFrames;
  String fname = String.format("../Assets/Vicky/Vicky%02d.jpg", fnum);
  PImage tex = loadImage(fname);
  
  final int res = 16;
  final int seg = width / res;
  final float slide = (1 - cos(time * PI * 2)) * 0.5;
  
  for (int y = 0; y < height; y++)
  {
    int iy = y * res / height;
    for (int x = 0; x < width; x++)
    {
      int ix = x * res / width;
      
      int dir = (ix + iy) % 2 < 1 ? -1 : 1;
      int dx = (int)(slide * seg * dir * res / 8);
      
      float h = 0.3 + 0.3 * dir;
      float s = slide;
      float b = brightness(tex.get(x + dx, y));
      b = round(b * 3) / 3.0;
      
      set(x, y, color(h, s, b));
    }
  }
 
//  if (frameCount <= 96) saveFrame();
}