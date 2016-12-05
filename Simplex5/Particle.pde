class Particle
{
  float x, y;
  float vx, vy;
  float life;
}

class ParticleSystem
{
  float decay = 2;
  float noiseFreq = 3;
  float noiseSpeed = 0.1;
  float noiseAccel = 1.2;

  SimplexNoise snoise;
  float time;
  Particle particles[];
  
  ParticleSystem(int num)
  {
    snoise = new SimplexNoise();
    time = 0;
    
    particles = new Particle[num];
    for (int i = 0; i < num; i++)
      particles[i] = new Particle();
  }
  
  Particle emit()
  {
    for (Particle p : particles)
      if (p.life <= 0) return p;
    return null;
  }
  
  void update(final float dt)
  {
    // time
    final float decay = exp(-this.decay * dt);
    time += dt;
    
    // noise
    final float freq = noiseFreq;
    final float offs = noiseSpeed * time;
    
    for (Particle p : particles)
    {
      p.life -= dt;
      if (p.life <= 0) continue;
      
      snoise.calculate(p.x * freq + 3, p.y * freq + 3 + offs);

      p.vx = decay * p.vx;
      p.vy = decay * p.vy;
      
      p.vx -= snoise.ddy * noiseAccel * dt;
      p.vy += snoise.ddx * noiseAccel * dt;
      
      p.x += p.vx * dt;
      p.y += p.vy * dt;
    }
  }
  
  void render()
  {
    for (Particle p : particles)
    {
      if (p.life <= 0) continue;
      final float sx = (p.x + 1) * 0.5 * width;
      final float sy = (p.y + 1) * 0.5 * height;
      final float r = p.life * 6;
      ellipse(sx, sy, r, r);
    }
  }
}