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
    0, 0, 10,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 + sin(PI * 4 * t) * 0.05);
  rotateY(-0.5 + sin(PI * 2 * t) * 0.1);
  
  int columns = 4;
  
  float offs = 0.5 * columns - 0.5;
  translate(-offs, 1, -offs);
  
  for (int ix = 0; ix < columns; ix++)
  {
    for (int iy = 0; iy < columns; iy++)
    {
      pushMatrix();
      translate(ix, 0, iy);
      
      float w = random(0.95, 1.0);
      float h = random(0.1, 0.6);
      drawUnit(w, h, 1, (int)random(4, 6));
      
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

  for (int i = 0; i < 4; i++)
  {
    float w2 = w * 0.5 * random(0.9, 1);
    float h2 = h * random(0.1, 1.6);
    
    float dx = w * 0.5 * ((i / 2) - 0.5);
    float dy = w * 0.5 * ((i & 1) - 0.5);
    
    int maxLv2 = maxLv + (int)random(-1, 1.1);
    
    pushMatrix();
    translate(dx, 0, dy);
    drawUnit(w2, h2, lv + 1, maxLv2);
    popMatrix();
  }
}