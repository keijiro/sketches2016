SimplexNoise ngen = new SimplexNoise();

void setup()
{
  size(300, 300);
  colorMode(RGB, 1);
}

void draw()
{
  final float freq = 3.0;
  final float offs = frameCount * 0.05;
  
  final int arrows = 20;
  final float larrow = 0.4 * width / arrows;
  
  for (int sy = 0; sy < height; sy++)
  {
    for (int sx = 0; sx < width; sx++)
    {
      float nx = sx * freq / width;
      float ny = sy * freq / height + offs;
      
      ngen.calculate(nx, ny);
      
      set(sx, sy, color(ngen.value * 0.8 + 0.5));
    }
  }
  
  stroke(1, 0.1, 0.1);
  
  for (int y = 0; y < arrows; y++)
  {
    for (int x = 0; x < arrows; x++)
    {
      float sx = (x + 0.5) * width / arrows;
      float sy = (y + 0.5) * height / arrows;

      float nx = sx * freq / width;
      float ny = sy * freq / height + offs;
      
      ngen.calculate(nx, ny);
      
      line(sx, sy, sx - ngen.ddy * larrow, sy + ngen.ddx * larrow);
    }
  }
  
//  if (frameCount <= 60) saveFrame();
}