int N = 17;
float[] gaussian = new float[N];

float timeToRotation(float t)
{
  t -= floor(t);
  if (t < 0.5)
  {
    return PI * 14 * t * t;
  }
  else
  {
    t = 1.0 - t;
    return -PI * 14 * t * t;
  }
}

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  textSize(16);
  textAlign(CENTER, CENTER);
  
  // Precalculate the Gaussian window.
  float sum = 0.0;
  for (int i = 0; i < N; i++)
  {
    float d = (i + 0.5) * 2 / N - 1;
    gaussian[i] = exp(-1.2 * d * d);
    sum += gaussian[i];
  }
  for (int i = 0; i < N; i++)
    gaussian[i] /= sum;
}

void draw()
{
  float totalFrames = 15 * 4;
  float t = (float)frameCount / totalFrames;
  float delta = 1.0 / totalFrames;
  
  background(1);
  
  drawText("Without Motion Blur", 0.25, 0.04);
  drawText("Box Filter", 0.75, 0.04);
  drawText("Triangle (Bartlett) Filter", 0.25, 0.54);
  drawText("Gaussian Filter", 0.75, 0.54);

  // Without filtering
  drawCross(0.25, 0.25, timeToRotation(t), 1);
  
  for (int i = 0; i < N; i++)
  {
    float dt = ((i + 0.5) / N - 0.5) * delta;

    // Box filter
    float w1 = 1.0 / N;
    
    // Triangle filter
    float w2 = (i + 0.5) * 2.0 / N;
    if (w2 > 1) w2 = 2 - w2;
    w2 *= 2.0 / N;
    
    // Gaussian filter
    float w3 = gaussian[i];
    
    float phi = timeToRotation(t + dt);
    drawCross(0.75, 0.25, phi, w1);
    drawCross(0.25, 0.75, phi, w2);
    drawCross(0.75, 0.75, phi, w3);
  }

  //if (frameCount <= totalFrames) saveFrame();
}

void drawCross(float x, float y, float phi, float alpha)
{
  pushMatrix();

  blendMode(SUBTRACT);
  fill(1, 1, 1, alpha);
  noStroke();

  x *= width;
  y *= height;
  
  translate(x, y);
  rotate(phi);
  
  float w = 0.03 * width;
  float h = 0.33 * width;

  for (int i = 0; i < 8; i++)
  {
    rect(-w / 2, -h / 2, w, h / 2 - w * 2);
    rotate(PI / 4);
  }
  
  popMatrix();
}

void drawText(String t, float x, float y)
{
  x *= width;
  y *= height;
  
  blendMode(BLEND);
  fill(0.05);
  noStroke();
  
  text(t, x, y);
}