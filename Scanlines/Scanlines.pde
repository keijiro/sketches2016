void setup()
{
  size(512, 512, P3D);
  colorMode(HSB, 1);
  smooth(4);
  strokeWeight(1.2);
}

void draw()
{
  int totalFrames = 96;
  float time = 1.0 / totalFrames * frameCount;

  int fnum = (frameCount - 1) % totalFrames;
  String fname = String.format("../Assets/Vicky/Vicky%02d.jpg", fnum);
  PImage tex = loadImage(fname);

  background(1);

  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 2.1 + sin(PI * 2 * time) * 0.5,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(0.2 * cos(PI * 2 * time) + 0.4);
  rotateZ(0.4 * sin(PI * 2 * time));
  
  final int res_x = 80;
  final int res_y = 90;
  
  final float dx = 1.0 / res_x;
  final float dy = 1.0 / res_y;

  for (int iy = 0; iy < res_y; iy++)
  {
    float amp = 2 - (iy * dy + time * 8) % 2;
    amp *= amp < 1 ? 0.45 : 0;

    float c1 = 0;
    
    stroke(iy * dy * 0.2, 1, 0.5);

    for (int ix = 0; ix < res_x; ix++)
    {
      float c2 = brightness(tex.get(
        (int)(ix * dy * tex.width),
        (int)(iy * dy * tex.height)
      ));
      
      if (ix > 0)
        line((ix - 1) * dx - 0.5, iy * dy - 0.5, c1 * amp,
              ix      * dx - 0.5, iy * dy - 0.5, c2 * amp);
      
      c1 = c2;
    }
  }
  
  //if (frameCount <= 96) saveFrame();
}