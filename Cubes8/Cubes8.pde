void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  frameRate(24);
  stroke(0, 0, 0);
}

void draw()
{
  int totalFrames = 24 * 4;
  float time = 1.0 / totalFrames * frameCount;

  background(0, 0, 1);

  randomSeed(1);
  noiseDetail(1);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 35 + sin(PI * 2 * time) * 4,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.8 + 0.2 * cos(PI * 2 * time));
  rotateZ(0.8 + 0.3 * sin(PI * 2 * time));
  
  final int slice = 30;
  final int ring = 26;
  final int radius = 4;
  
  int id = 0;
  for (int i = 0; i < slice; i++)
  {
    float y = i - slice / 2 + 0.5;
    float em = sin(i * 0.2 + time * PI * 2) * 0.5 + 0.6;
    
    for (int j = 0; j < ring; j++)
    {
      float phi = 2 * PI * j / ring;
      
      float l = lerp(0.5, 1.2, em) * radius;
      float s = lerp(0.4, 1.1, em);
      
      s *= abs((id * 0.07151 + time * 6) % 2 - 1);

      pushMatrix();
      translate(0, y, 0);
      rotateY(phi);
      translate(0, 0, l);
      box(s, s, s);
      popMatrix();
      
      id++;
    }
  }
  
  if (frameCount <= totalFrames) saveFrame();
}