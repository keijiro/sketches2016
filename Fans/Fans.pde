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

void drawRing(float l0, float l1, int fans)
{
  for (int fan = 0; fan < fans; fan += 2)
  {
    float phi0 = fan2phi(fan, fans);
    float phi1 = fan2phi(fan + 1, fans);
    float phi2 = fan2phi(fan + 2, fans);
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
  frameRate(2);
  
  smooth();
  strokeWeight(0.5);
  noFill();
  stroke(0);
}

void draw()
{
  background(255);

  int fans = 32;
  int lines = 32;

  for (int i = 0; i < lines; i++)
  {
    float l0 = random(0.1, 0.6);
    float l1 = abs(l0 + random(-0.3, 0.3));
    drawRing(l0, l1, fans);
  }

  for (int i = 0; i < lines * 2; i++)
  {
    float l0 = random(0.5, 1.5);
    float l1 = abs(l0 + random(-0.15, 0.15));
    drawRing(l0, l1, fans * 2);
  }
  
  saveFrame();
}