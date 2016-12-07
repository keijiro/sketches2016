final class Boundary
{
  float clip = 0.5;
  
  float distance;
  float ddx;
  float ddy;
  
  public void calculate(float x, float y)
  {
    calculateDistance(x, y);
    calculateGradient(x, y);
  }
  
  public float calculateDistance(float x, float y)
  {
    float d = clip;
    
    d = min(d, max(0.8 + x, 0));
    d = min(d, max(0.8 - x, 0));

    d = min(d, max(0.8 + y, 0));
    d = min(d, max(0.8 - y, 0));
    
    d = min(d, max(pointDF(x, y, 0, 0, 0.1), 0));
    d = min(d, max(pointDF(x, y, 0.2, 0.3, 0.15), 0));
    d = min(d, max(pointDF(x, y, -0.45, 0.2, 0.2), 0));
    d = min(d, max(pointDF(x, y, 0.4, -0.35, 0.2), 0));
    
    distance = d / clip;
    return distance;
  }

  public void calculateGradient(float x, float y)
  {
    float epsilon = clip * 0.00001;
    
    float d0 = calculateDistance(x - epsilon, y);
    float d1 = calculateDistance(x + epsilon, y);
    float d2 = calculateDistance(x, y - epsilon);
    float d3 = calculateDistance(x, y + epsilon);
    
    ddx = (d1 - d0) / (2 * epsilon);
    ddy = (d3 - d2) / (2 * epsilon);
  }
  
  private float pointDF(float x, float y, float ox, float oy, float r)
  {
    float dx = x - ox;
    float dy = y - oy;
    float d = sqrt(dx * dx + dy * dy);
    return d - r;
  }
}