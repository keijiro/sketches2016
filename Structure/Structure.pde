void setup()
{
  size(500, 500, P3D);
  colorMode(RGB, 1);
}

void draw()
{
  int totalFrames = 24 * 3;
  float t = (float)frameCount / totalFrames;
  
  randomSeed(0);
  
  background(1);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 40,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 + sin(PI * 4 * t) * 0.05);
  rotateY(-0.5 + sin(PI * 2 * t) * 0.1);
  
  int columns = 16;
  
  float offs = 0.5 * columns - 0.5;
  translate(-offs, 3, -offs);
  
  for (int ix = 0; ix < columns; ix++)
  {
    for (int iy = 0; iy < columns; iy++)
    {
      pushMatrix();
      translate(ix, 0, iy);

      float w = random(0.2, 0.9);
      float h = w * random(2, 6);
      
      float dx = random(-0.5, 0.5) * (1 - w);
      float dy = random(-0.5, 0.5) * (1 - w);
      
      translate(dx, 0, dy);
      drawUnit(w, h, 1, (int)random(2, 8));
      
      popMatrix();
    }
  }
  
  //if (frameCount <= totalFrames) saveFrame();
}

void drawUnit(float w, float h, int lv, int maxLv)
{
  if (lv >= maxLv) return;
  
  translate(0, -0.5 * h, 0);
  box(w, h, w);
  translate(0, -0.5 * h, 0);

  w *= random(0.5, 0.9);
  h *= random(0.2, 0.8);

  drawUnit(w, h, lv + 1, maxLv);
}