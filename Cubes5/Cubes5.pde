void setup()
{
  size(500, 500, P3D);
  colorMode(RGB, 1);
  frameRate(24);
}

void draw()
{
  int columns = 8;
  int totalFrames = 3 * 24;
  float time = 1.0 / totalFrames * frameCount;

  background(1);
  randomSeed(10);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 3.2 + sin(PI * 2 * time) * 0.5,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 - 0.05 * sin(PI * 4 * time));
  rotateY(-0.5 - 0.05 * cos(PI * 2 * time));

  int id = 0;
  for (int ix = 0; ix < columns; ix++)
  {
    float x = (ix + 0.5) / columns - 0.5;
    for (int iy = 0; iy < columns; iy++)
    {
      float y = (iy + 0.5) / columns - 0.5;
      for (int iz = 0; iz < columns; iz++)
      {
        float z = (iz + 0.5) / columns - 0.5;
        float s = abs(((id * PI / 17 + time * 6) % 2) - 1) / columns;
        
        pushMatrix();
        translate(x, y, z);
        box(s, s, s);
        popMatrix();
        
        id++;
      }
    }
  }
  
//  if (frameCount <= totalFrames) saveFrame();
}