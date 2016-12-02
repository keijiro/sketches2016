SimplexNoise sn = new SimplexNoise();
Particle[] particles = new Particle[1024];

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  noFill();
  stroke(0, 0.5);
  
  //frameRate(24);
  
  for (int i = 0; i < particles.length; i++)
    particles[i] = new Particle();
}

void draw()
{
  background(1);

  float offs = frameCount * 0.04;

  for (int i = 0; i < particles.length; i++)
  {
    Particle p = particles[i];
    p.update(1.0 / 24, sn, offs);
    p.draw();
  }
  
  //if (frameCount <= 24 * 5) saveFrame();
}