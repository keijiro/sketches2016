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
  Particle particles[];
  float time;
  
  ParticleSystem(int num)
  {
    snoise = new SimplexNoise();

    particles = new Particle[num];
    for (int i = 0; i < num; i++)
      particles[i] = new Particle();
    
    time = 0;
  }
  
  Particle emit()
  {
    for (Particle p : particles)
      if (p.life <= 0) return p;
    return null;
  }
  
  void update(float dt, Boundary bound)
  {
    // time
    float decay = exp(-this.decay * dt);
    time += dt;
    
    // noise
    float offs = noiseSpeed * time;
    
    for (Particle p : particles)
    {
      p.life -= dt;
      if (p.life <= 0) continue;
      
      snoise.calculate(p.x * noiseFreq, p.y * noiseFreq + offs);
      bound.calculate(p.x, p.y);
      
      float dfnx = bound.distance * snoise.ddx + bound.ddx * snoise.value;
      float dfny = bound.distance * snoise.ddy + bound.ddy * snoise.value;

      p.vx = decay * p.vx;
      p.vy = decay * p.vy;
      
      p.vx -= dfny * noiseAccel * dt;
      p.vy += dfnx * noiseAccel * dt;
      
      p.x += p.vx * dt;
      p.y += p.vy * dt;
    }
  }
  
  void render()
  {
    for (Particle p : particles)
    {
      if (p.life <= 0) continue;
      float sx = (p.x + 1) * 0.5 * width;
      float sy = (p.y + 1) * 0.5 * height;
      float r = min(p.life, 4.0) * 0.015 * width;
      ellipse(sx, sy, r, r);
    }
  }
}