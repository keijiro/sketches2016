void setup()
{
  colorMode(RGB, 1);
  size(500, 500, P3D);
  frameRate(24);
}

void draw()
{
  int frames = 24 * 4;
  float t = (float)frameCount / frames;
  
  background(0);
  noStroke();
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 25 + sin(PI * 2 * t) * 3,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 - 0.05 * sin(PI * 4 * t));
  rotateY(-0.5 - 0.05 * cos(PI * 2 * t));
  
  int columns = 8;
  color c0 = color(0.8, 0, 0);
  color c1 = color(1, 1, 0.8);
  for (int ix = 0; ix < columns; ix++)
  {
    float x = ix - 0.5 * columns + 0.5;
    for (int iy = 0; iy < columns; iy++)
    {
      float y = iy - 0.5 * columns + 0.5;
      for (int iz = 0; iz < columns; iz++)
      {
        float z = iz - 0.5 * columns + 0.5;

        float d = sqrt(x * x + y * y + z * z);
        float s = abs(sin(d - t * 4 * PI));
      
        pushMatrix();
        translate(x, z, y);
        fill(lerpColor(c0, c1, s));
        box(s);
        popMatrix();
      }
    }
  }
  
  //if (frameCount <= frames) saveFrame();
}