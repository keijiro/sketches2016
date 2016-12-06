ParticleSystem ps = new ParticleSystem(2048);
Boundary bd = new Boundary();

void setup()
{
  size(500, 500);
  colorMode(RGB, 1);
  stroke(0, 0.6);
  noFill();
  
  frameRate(24);

  ps.decay = 14;
  ps.noiseFreq = 0.7;
  ps.noiseSpeed = 0.5;
  ps.noiseAccel = 5;
}

void draw()
{
  background(1);
  
  if(false)
  for (int sy = 0; sy < height; sy++)
  {
    for (int sx = 0; sx < width; sx++)
    {
      float x = 2.0 * sx / width - 1.0;
      float y = 2.0 * sy / height - 1.0;
      
      float p = bd.calculatePotential(x, y);
      set(sx, sy, color(p * 0.3 + 0.7));
      
//      bd.calculateGradient(x, y);
//      set(sx, sy, color((bd.ddx + 1) * 0.5, (bd.ddy + 1) * 0.5, 0));
    }
  }

  rect(0.1 * width, 0.1 * height, 0.8 * width, 0.8 * height);

  for (int i = 0; i < 7; i++)
  {
    Particle p = ps.emit();
    if (p == null) break;
    
    p.x = random(-0.7, 0.7);
    p.y = random(-0.7, 0.7);
    p.vx = random(-1, 1);
    p.vy = random(-1, 1);
    p.life = random(2, 4);
  }

  ps.update(1.0 / 24);
  ps.render();

  if (frameCount <= 24 * 7) saveFrame();
}