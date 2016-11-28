int N = 13;
float[] gaussian = new float[N];

float position(float t)
{
  return (1.0 - cos(PI * 2 * t)) * 0.5;
}

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  frameRate(13);
  textSize(16);
  textAlign(LEFT, BOTTOM);
  
  // Precalculate the Gaussian window.
  float sum = 0.0;
  for (int i = 0; i < N; i++)
  {
    float d = (i + 0.5) * 2 / N - 1;
    gaussian[i] = exp(-1.5 * d * d);
    sum += gaussian[i];
  }
  for (int i = 0; i < N; i++)
    gaussian[i] /= sum;
}

void draw()
{
  float totalFrames = 13;
  float t = (float)frameCount / totalFrames;
  float delta = 1.0 / totalFrames;
  
  if (frameCount > totalFrames * 2)
    t = (float)((frameCount - totalFrames * 2) / 5) / totalFrames;
  
  background(1);
  
  drawText("Without Motion Blur", 0, 0.13);
  drawText("Box Filter", 0, 0.33);
  drawText("Triangle (Bartlett) Filter", 0, 0.53);
  drawText("Gaussian Filter", 0, 0.73);

  // Without filtering
  drawBall(position(t), 0.2, 1);
  
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
    
    drawBall(position(t + dt), 0.4, w1);
    drawBall(position(t + dt), 0.6, w2);
    drawBall(position(t + dt), 0.8, w3);
  }

  if (frameCount <= 7 * totalFrames) saveFrame();
}

void drawBall(float x, float y, float alpha)
{
  x = lerp(0.15, 0.85, x) * width;
  y = lerp(0, 1, y) * height;
  float w = 0.1 * width;
  blendMode(SUBTRACT);
  fill(1, 1, 1, alpha);
  noStroke();
  ellipse(x, y, w, w);
}

void drawText(String t, float x, float y)
{
  x = lerp(0.15, 0.85, x) * width;
  y = lerp(0, 1, y) * height;
  blendMode(BLEND);
  fill(0.05);
  noStroke();
  text(t, x, y);
}