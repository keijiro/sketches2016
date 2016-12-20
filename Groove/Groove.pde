void setup()
{
  size(512, 512, P2D);
  colorMode(HSB, 1);
  smooth(4);
}

void draw()
{
  int totalFrames = 96;
  float time = 1.0 / totalFrames * frameCount;

  int fnum = (frameCount - 1) % totalFrames;
  String fname = String.format("../Assets/Vicky/Vicky%02d.jpg", fnum);
  PImage tex = loadImage(fname);

  background(1);

  final int res_x = 512;
  final int res_y = 50;
  
  final float dx = 1.0 / res_x;
  final float dy = 1.0 / res_y;

  for (int iy = 0; iy < res_y; iy++)
  {
    float t = 0;
    float b1 = 0;
    float y1 = 0;
    
    for (int ix = 0; ix < res_x; ix++)
    {
      float b = brightness(tex.get(
        (int)(ix * dx * tex.width),
        (int)(iy * dy * tex.height)
      ));
      
      b = lerp(b1, b, 0.05);
      
      t += lerp(100, 900, b) * dx;
      
      float y2 = sin(t) * 0.4 * min(b * 3, 1);
      
      if (ix > 0)
        line((ix - 1) * dx * width, (iy + y1) * dy * height,
              ix      * dx * width, (iy + y2) * dy * height);

      y1 = y2;
      b1 = b;
    }
  }
  
  //if (frameCount <= 96) saveFrame();
}