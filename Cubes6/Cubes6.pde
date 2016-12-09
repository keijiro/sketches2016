void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  frameRate(24);
  stroke(0, 0, 0.4);
}

void draw()
{
  int columns = 8;
  int totalFrames = 74;
  float time = 1.0 / totalFrames * frameCount;
  float time2 = max(0, (time % 1) - 0.25) / 0.75;
  float param = 0.5 - 0.5 * cos(time2 * PI * 2);

  background(0.15, 0.05, 1);

  randomSeed(10);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 3.2 + sin(PI * 2 * time) * 0.5,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.5 - 0.05 * sin(PI * 4 * time));
  rotateY(-0.5 - 0.15 * cos(PI * 2 * time));
  
  int id = 0;
  for (int iz = 0; iz < columns; iz++)
  {
    float z = 0.5 - (iz + 0.5) / columns;
    for (int iy = 0; iy < columns; iy++)
    {
      float y = (iy + 0.5) / columns - 0.5;
      for (int ix = 0; ix < columns; ix++)
      {
        float x = 0.5 - (ix + 0.5) / columns;
        float s = abs(((id * PI / 17 + time * 6) % 2) - 1);
        
        fill(lerp(0.3, 0, s) + param * 0.2, 0.7 - 0.2 * param, 1);
        
        float px = lerp(x, random(-1, 1), param);
        float py = lerp(y, random(-1, 1), param);
        float pz = lerp(z, random(-1, 1), param);
        
        float rx = random(-1, 1) * PI * 2 * param;
        float ry = random(-1, 1) * PI * 2 * param;
        float rz = random(-1, 1) * PI * 2 * param;
        
        s /= columns;

        pushMatrix();
        translate(px, py, pz);
        rotateX(rx);
        rotateY(ry);
        rotateZ(rz);
        box(s, s, s);
        popMatrix();
        
        id++;
      }
    }
  }
  
  if (frameCount <= totalFrames) saveFrame();
}