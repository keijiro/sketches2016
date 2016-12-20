PImage tex;

void setup()
{
  size(512, 512, P2D);
  colorMode(HSB, 1);
  smooth(8);

  tex = loadImage("../Assets/MonaLisa.jpg");
}

void draw()
{
  final int totalFrames = 24 * 3;
  float time = 1.0 / totalFrames * frameCount;

  background(1);

  final int res_x = width;
  final int res_y = 80;
  
  final float dx = 1.0 / res_x;
  final float dy = 1.0 / res_y;

  float omega = sin(time % 1 * PI / 2);

  for (int iy = 0; iy < res_y; iy++)
  {
    float t = 0;
    float b1 = 0;
    float y1 = 0;
    
    for (int ix = 0; ix < res_x; ix++)
    {
      float b = 1 - brightness(tex.get(
        (int)(lerp(0.2, 0.8, ix * dx) * tex.width),
        (int)(lerp(0.1, 0.7, iy * dy) * tex.width)
      ));
      
      b = lerp(b1, b, 0.5);
      
      t += lerp(50, 1000, b) * dx * omega;
      
      float y2 = sin(t) * 0.48 * b;
      
      if (ix > 0)
        line((ix - 1) * dx * width, (iy + y1 + 0.5) * dy * height,
              ix      * dx * width, (iy + y2 + 0.5) * dy * height);

      y1 = y2;
      b1 = b;
    }
  }
  
//  if (frameCount <= totalFrames) saveFrame();
}