float smoothstep(float x, float low, float high)
{
  x = constrain((x - low) / (high - low), 0, 1);
  return (3 - 2 * x) * x * x;
}

void setup()
{
  size(500, 500, P3D);
  colorMode(HSB, 1);
  frameRate(24);
  stroke(0, 0, 0);
}

void draw()
{
  int totalFrames = 24 * 5;
  float time = 1.0 / totalFrames * frameCount;

  background(0, 0, 1);

  randomSeed(1);
  noiseDetail(0);
  
  perspective(0.5, 1, 0.01, 100);
  
  camera(
    0, 0, 3.2 + sin(PI * 2 * time) * 0.5,
    0, 0, 0,
    0, 1, 0
  );

  rotateX(-0.9 + 0.4 * cos(PI * 2 * time));
  rotateZ(0.3 * sin(PI * 1.8 * time));
  
  for (int i = 0; i < 300; i++)
  {
    float y = random(-1, 1);
    y *= smoothstep(time, 0, 0.1);
    y *= smoothstep(time, 1, 0.9);
    
    float l = random(0.2, 0.7);
    l *= smoothstep(time, 0.05, 0.5);
    l *= smoothstep(time, 0.9, 0.8);
        
    float omega = random(6, 20);
    float phi = omega * (time + 0.2);

    float s = noise(i * 0.132 + time) * 0.2;
    s *= smoothstep(time, 0, 0.05);
    s *= smoothstep(time, 1, 0.95);

    pushMatrix();
    translate(0, y, 0);
    rotateY(phi);
    translate(0, 0, l);
    box(s, s, s);
    popMatrix();
  }
  
  //if (frameCount <= totalFrames + 8) saveFrame();
}