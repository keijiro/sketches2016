float time;

float rnoise(float x)
{
  float t1 = time * 4;
  float t2 = (time - 1) * 4;
  float n1 = noise(x, t1);
  float n2 = noise(x, t2);
  float n = lerp(n1, n2, time);
  return constrain(n * 5 - 0.2, 0, 1);
}

void setup()
{
  size(500, 500, P3D);
  colorMode(RGB, 1);
  noiseDetail(1);
}

void draw()
{
  int totalFrames = 24 * 3;
  time = (float)frameCount / totalFrames;
  
  randomSeed(132);
  
  background(1);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 11,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 + sin(PI * 4 * time) * 0.1);
  rotateY(-0.5 + sin(PI * 2 * time) * 0.2);
  
  drawSurface(0, 0);
  drawSurface(90, 0);
  drawSurface(180, 0);
  drawSurface(-90, 0);
  drawSurface(90, 90);
  drawSurface(90, -90);

//  if (frameCount <= totalFrames) saveFrame();
}

void drawSurface(float rx, float ry)
{
  int columns = 2;

  pushMatrix();
  
  rotateY(radians(ry));
  rotateX(radians(rx));

  float offs = 0.5 * columns - 0.5;
  translate(-offs, -0.5 * columns, -offs);
  
  for (int ix = 0; ix < columns; ix++)
  {
    for (int iy = 0; iy < columns; iy++)
    {
      pushMatrix();
      translate(ix, 0, iy);
      
      float w = random(0.95, 1.0);
      float h = 0.2;
      drawUnit(w, h, 1, (int)random(4, 6));
      
      popMatrix();
    }
  }
  
  popMatrix();
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
    float h2 = h * random(0.1, 1.75);
    
    h2 *= rnoise(random(0, 10));
    
    float dx = w * 0.5 * ((i / 2) - 0.5);
    float dy = w * 0.5 * ((i & 1) - 0.5);
    
    int maxLv2 = maxLv + (int)random(-1, 1.1);
    
    pushMatrix();
    translate(dx, 0, dy);
    drawUnit(w2, h2, lv + 1, maxLv2);
    popMatrix();
  }
}