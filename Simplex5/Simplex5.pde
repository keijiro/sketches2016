ParticleSystem ps = new ParticleSystem(2048);

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  noStroke();
  fill(1, 0.4, 0.2, 0.5);
  blendMode(ADD);
  
  frameRate(24);

  ps.decay = 2.0;
  ps.noiseFreq = 1.5;
  ps.noiseSpeed = 0.6;
  ps.noiseAccel = 1;
}

void draw()
{
  background(0);
  
  if (frameCount < 24)
  {
    for (int i = 0; i < 40; i++)
    {
      Particle p = ps.emit();
      if (p != null)
      {
        p.x = random(-0.1, 0.1);
        p.y = random(0.95, 1);
        p.vx = random(-0.8, 0.8);
        p.vy = -random(0.8, 3.4);
        p.life = random(2, 4);
      }
    }
  }

  ps.update(1.0 / 24);
  ps.render();

//  if (frameCount <= 24 * 5) saveFrame();
}