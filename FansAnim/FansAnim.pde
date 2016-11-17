float fan2phi(int fan, int fans)
{
  return PI * 2 * fan / fans;
}

PVector polar(float phi, float l)
{
  float sn = sin(phi);
  float cs = cos(phi);
  return new PVector(
    (cs * l + 1) * 0.5 * width,
    (sn * l + 1) * 0.5 * height
  );
}

void drawRing(float l0, float l1, int fans, float offs)
{
  for (int fan = 0; fan < fans; fan += 2)
  {
    float phi0 = fan2phi(fan, fans) + offs;
    float phi1 = fan2phi(fan + 1, fans) + offs;
    float phi2 = fan2phi(fan + 2, fans) + offs;
    PVector v0 = polar(phi0, l0);
    PVector v1 = polar(phi1, l1);
    PVector v2 = polar(phi2, l0);
//    line(v0.x, v0.y, v1.x, v1.y);
//    line(v1.x, v1.y, v2.x, v2.y);
    bezier(v0.x, v0.y, v1.x, v1.y, v1.x, v1.y, v2.x, v2.y);
  }
}

void setup()
{
  size(500, 500);
//  frameRate(15);
  
  smooth();
  strokeWeight(0.5);
  noFill();
  stroke(0);
}

void draw()
{
  background(255);
  
  randomSeed(16);
  
  int total = 24 * 3;

  int fans = 24;
  int lines = 48;
  float t = PI * 2 * frameCount / total;
  float rot = PI * 4 * frameCount / (fans * total);

  for (int i = 0; i < lines; i++)
  {
    float l0 = random(0.1, 0.6);
    float l1 = l0 + random(-0.2, 0.2);
    l0 += sin(t + random(PI * 2)) * random(0.2);
    l1 += sin(t + random(PI * 2)) * random(0.2);
    drawRing(abs(l0), abs(l1), fans, rot);
  }

  for (int i = 0; i < lines * 2; i++)
  {
    float l0 = random(0.5, 1.5);
    float l1 = l0 + random(-0.15, 0.15);
    l0 += sin(t + random(PI * 2)) * random(0.2);
    l1 += sin(t + random(PI * 2)) * random(0.2);
    drawRing(l0, l1, fans * 3, rot);
  }
  
  if (frameCount <= total) saveFrame();
}