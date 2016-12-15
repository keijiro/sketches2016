final boolean colored = false;

void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  frameRate(24);
  stroke(0, 0, colored ? 0.4 : 0);
  smooth(4);
}

void draw()
{
  int totalFrames = 24 * 4;
  float time = 1.0 / totalFrames * frameCount;

  background(0.13, colored ? 0.07 : 0.03, 1);

  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 18 + sin(PI * 2 * time) * 1.5,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(0.11 * cos(PI * 2 * time) - 1.1);
  rotateZ(0.11 * sin(PI * 2 * time));
  
  final int points = 52;
  final int rings = 22;
  final float radius = 9;
  
  int id = 0;
  for (int i = 0; i < rings; i++)
  {
    float s = pow(1.0 / rings * i, 2);
    float l = radius * s;
    
    for (int j = 0; j < points; j++)
    {
      float phi = 2 * PI * j / points;
      float a = abs((abs(1.0 / 23 * id - time * 6) % 2) - 1);
      float s2 = a + 0.15;
      
      fill(lerp(0.18, 0.39, a), 0.3, 1);
      
      pushMatrix();
      rotateY(phi);
      translate(0, 0, l);
      box(s2 * s, s2 * s, s2 * s);
      popMatrix();
      
      id++;
    }
  }
  
//  if (frameCount <= totalFrames) saveFrame();
}