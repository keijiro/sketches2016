final boolean colored = true;

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
    0, 0, 32 + sin(PI * 2 * time) * 5,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.8 + 0.1 * cos(PI * 2 * time));
  rotateZ( 0.8 + 0.1 * sin(PI * 2 * time));
  
  final int slice = 24;
  final int ring = 44;
  final int radius = 8;
  
  int id = 0;
  for (int i = 0; i <= slice; i++)
  {
    float theta = (1.0 * i / slice) % 1;
    theta = PI * (theta - 0.5);
    
    for (int j = 0; j < ring; j++)
    {
      float phi = 2 * PI * j / ring;
      
      float s = cos(theta);
      float l = radius;
      
      s *= abs(abs(1.0 * id / 24 + time * 6) % 2 - 1);
      s *= 1.15;
      
      if (colored) fill(s * 0.28 + 0.17, 0.4, 1);

      pushMatrix();
      rotateY(phi);
      rotateX(-theta);
      translate(0, 0, l);
      box(s, s, s);
      popMatrix();
      
      id++;
    }
  }
  
  if (frameCount <= totalFrames) saveFrame();
}