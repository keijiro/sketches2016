ParticleSystem ps = new ParticleSystem(2048);
Boundary bd = new Boundary();

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  stroke(0.2, 1);
  noFill();
  
  frameRate(24);
  
  bd.clip = 0.8;
  ps.decay = 24;
  ps.noiseFreq = 0.4;
  ps.noiseSpeed = 0.3;
  ps.noiseAccel = 12;
}

void draw()
{
  background(1);
  
  for (int sy = 0; sy < height; sy++)
  {
    for (int sx = 0; sx < width; sx++)
    {
      float x = 2.0 * sx / width - 1.0;
      float y = 2.0 * sy / height - 1.0;
      
      float d = bd.calculateDistance(x, y);
      set(sx, sy, color(d <= 0 ? 0.5 : 1.0));
      //set(sx, sy, color(d));
    }
  }

  for (int i = 0; i < 7; i++)
  {
    Particle p = ps.emit();
    if (p == null) break;
    
    while (true)
    {
      p.x = random(-0.7, 0.7);
      p.y = random(-0.7, 0.7);
      if (bd.calculateDistance(p.x, p.y) > 0.1) break;
    }
    
    p.vx = random(-1, 1);
    p.vy = random(-1, 1);
    p.life = random(2, 4);
  }

  ps.update(1.0 / 24, bd);
  ps.render();

  if (frameCount <= 24 * 8) saveFrame();
}