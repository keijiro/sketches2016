final class Boundary
{
  float ddx;
  float ddy;
  
  public void calculateGradient(final float x, final float y)
  {
    final float epsilon = 0.00001;
    
    final float p0 = calculatePotential(x - epsilon, y);
    final float p1 = calculatePotential(x + epsilon, y);
    final float p2 = calculatePotential(x, y - epsilon);
    final float p3 = calculatePotential(x, y + epsilon);
    
    ddx = (p1 - p0) / (2 * epsilon);
    ddy = (p3 - p2) / (2 * epsilon);
  }
  
  public float calculatePotential(final float x, final float y)
  {
    float p = 1;
    
    if (x < -0.55) p *= max(0.8 + x, 0) * 4;
    if (x >  0.55) p *= max(0.8 - x, 0) * 4;

    if (y < -0.55) p *= max(0.8 + y, 0) * 4;
    if (y >  0.55) p *= max(0.8 - y, 0) * 4;
    
    return p;
  }
}