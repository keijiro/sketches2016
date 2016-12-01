void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
}

void draw()
{
  float[] grad = new float[2];
  float offs = frameCount * 0.1;
  
  SimplexNoise ng = new SimplexNoise();
  
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      float sx = 3.0 / width * x + offs;
      float sy = 3.0 / height * y + offs / 2;
      
      ng.calculate(sx, sy);
      
      float n = ng.value + 0.5;
      color c = color(n, n + ng.ddx * 0.3, n + ng.ddy * 0.3);
      
      set(x, y, c);
    }
  }
  
  if (frameCount <= 20) saveFrame();
}