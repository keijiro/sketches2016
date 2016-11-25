float x1;
float v1 = 3;
FloatList x1h = new FloatList();

float x2;
float v2 = 8;
FloatList x2h = new FloatList();

float x3, v3;
float k3 = 14;
FloatList x3h = new FloatList();

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  frameRate(30);
  textSize(16);
  textAlign(LEFT, BOTTOM);
}

void draw()
{
  float totalFrames = 30 * 3;
  float t = (float)frameCount / totalFrames;
  float delta = 1.0 / totalFrames;
  
  background(1);
  
  if (frameCount * 2 % totalFrames == 0)
  {
    x1h.clear();
    x2h.clear();
    x3h.clear();
  }
  
  // Target
  float x = (t % 1) < 0.5 ? 1 : 0;
  
  drawText("Target", 0, 0.13);
  drawBall(x, 0.2, true);
  
  // Linear interpolation
  if (x1 < x)
    x1 = min(x1 + v1 * delta, x);
  else
    x1 = max(x1 - v1 * delta, x);

  drawText("Linear Interpolation", 0, 0.33);
  for (int i = 0; i < x1h.size(); i++)
    drawBall(x1h.get(i), 0.4, false);
  drawBall(x1, 0.4, true);
  
  x1h.append(x1);
  
  // Exponential interpolation
  x2 = lerp(x, x2, exp(-v2 * delta));

  drawText("Exponential Interpolation", 0, 0.53);
  for (int i = 0; i < x2h.size(); i++)
    drawBall(x2h.get(i), 0.6, false);
  drawBall(x2, 0.6, true);

  x2h.append(x2);

  // Damped spring motion
  float n1 = v3 - (x3 - x) * (k3 * k3 * delta);
  float n2 = 1.0 + k3 * delta;
  v3 = n1 / (n2 * n2);
  x3 += v3 * delta;
  
  drawText("Damped Spring Motion", 0, 0.73);
  for (int i = 0; i < x3h.size(); i++)
    drawBall(x3h.get(i), 0.8, false);
  drawBall(x3, 0.8, true);

  x3h.append(x3);

//  if (frameCount >= totalFrames && frameCount < totalFrames * 2) saveFrame();
}

void drawBall(float x, float y, boolean fg)
{
  x = lerp(0.15, 0.85, x) * width;
  y = lerp(0, 1, y) * height;
  float w = 0.1 * width;
  noFill();
  stroke(fg ? 0.3 : 0.8);
  strokeWeight(fg ? 1.5 : 1);
  ellipse(x, y, w, w);
}

void drawText(String t, float x, float y)
{
  x = lerp(0.15, 0.85, x) * width;
  y = lerp(0, 1, y) * height;
  fill(0.05);
  noStroke();
  text(t, x, y);
}