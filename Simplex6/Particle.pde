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
  Boundary boundary;
  float time;
  Particle particles[];
  
  ParticleSystem(int num)
  {
    snoise = new SimplexNoise();
    boundary = new Boundary();
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
    final float offs = noiseSpeed * time;
    
    for (Particle p : particles)
    {
      p.life -= dt;
      if (p.life <= 0) continue;
      
      snoise.calculate(p.x * noiseFreq + 3, p.y * noiseFreq + 3 + offs);
      float pot = boundary.calculatePotential(p.x, p.y);
      boundary.calculateGradient(p.x, p.y);
      
      float dfnx = pot * snoise.ddx + boundary.ddx * snoise.value;
      float dfny = pot * snoise.ddy + boundary.ddy * snoise.value;

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
      final float sx = (p.x + 1) * 0.5 * width;
      final float sy = (p.y + 1) * 0.5 * height;
      final float r = p.life * 6;
      ellipse(sx, sy, r, r);
    }
  }
}