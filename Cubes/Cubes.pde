PShape cube;

void setup()
{
  size(500, 500, P3D);
  //frameRate(24);
  cube = createShape(BOX, 1, 1, 1);
}

void draw()
{
  int frames = 24 * 4;
  float t = (float)frameCount / frames;
  
  background(255);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 40 + sin(PI * 2 * t) * 10,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 - 0.15 * sin(PI * 4 * t));
  rotateY(-0.5 - 0.15 * cos(PI * 2 * t));
  
  int columns = 15;
  for (int ix = 0; ix < columns; ix++)
  {
    float x = (ix - 0.5 * columns + 0.5) * 1.2;
    
    for (int iy = 0; iy < columns; iy++)
    {
      float y = (iy - 0.5 * columns + 0.5) * 1.2;
      float d = sqrt(x * x + y * y);
      float z = sin(d * 0.45 + t * 4 * PI);
      z = z * z * z * 2;
      
      pushMatrix();
      translate(x, z, y);
      shape(cube);
      popMatrix();
    }
  }
  
  if (frameCount <= frames) saveFrame();
  
}