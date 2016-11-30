void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
}

void draw()
{
  float xs = 3.0 / width;
  float ys = 3.0 / height;
  float z = 0.1 * frameCount;
  
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      float n = (float)SimplexNoise.noise(xs * x, ys * y, z);
      set(x, y, color(n * 0.5 + 0.5));
    }
  }
  
//  if (frameCount <= 24 * 3 / 2) saveFrame();
}