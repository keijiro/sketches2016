class Particle
{
  float x, y;
  float vx, vy;
  float life;
  
  Particle()
  {
    init();
  }
  
  void init()
  {
    x = random(-0.2, 0.2);
    y = random(-0.2, 0.2);
    vx = 0;
    vy = 0;
    life = random(3, 5);
  }
  
  void update(float dt, SimplexNoise sn, float offs)
  {
    life -= dt;
    
    if (life <= 0) return;
    
    float decay = exp(-3 * dt);
    float freq = 2.5;
    float acc = 1.2;
    
    sn.calculate(x * freq, y * freq + offs);
    
    vx = decay * vx;
    vy = decay * vy;
    
    vx -= sn.ddy * acc * dt;
    vy += sn.ddx * acc * dt;
    
    x += vx * dt;
    y += vy * dt;
  }
  
  void draw()
  {
    if (life <= 0) return;
    float sx = (x + 1) * 0.5 * width;
    float sy = (y + 1) * 0.5 * height;
    float r = life * 6;
    ellipse(sx, sy, r, r);
  }
}