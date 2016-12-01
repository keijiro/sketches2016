void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
}

void draw()
{
  float[] grad = new float[2];
  float offs = frameCount * 0.1;
  
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      float sx = 3.0 / width * x + offs;
      float sy = 3.0 / height * y + offs / 2;
      float n = SimplexNoise.sdnoise2(sx, sy, grad) * 1.5 + 0.5;
      color c = color(n, n + grad[0] * 0.3, n + grad[1] * 0.3);
      set(x, y, c);
    }
  }
}