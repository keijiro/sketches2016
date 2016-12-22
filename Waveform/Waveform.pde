final int fps = 24;
final int totalFrames = fps * 4;
final int sampleRate = 44100;

float[][] waveform;

void loadWaveform(String path)
{
  final byte[] raw = loadBytes(path);
  final int count = raw.length / 4;
  
  waveform = new float[2][count];
  
  int offs = 0;
  for (int i = 0; i < count; i++)
  {
    waveform[0][i] = (float)(raw[offs++] + raw[offs++] * 256) / 65536;
    waveform[1][i] = (float)(raw[offs++] + raw[offs++] * 256) / 65536;
  }
}

float getLevel(float t, int ch)
{
  final int count = waveform[0].length;

  final float p = t * sampleRate;
  final int p_ = floor(p);
  final int i = constrain(p_, 0, count - 2);
  
  final float w1 = waveform[ch][i    ];
  final float w2 = waveform[ch][i + 1];
  
  return lerp(w1, w2, p - p_);
}

PVector getPoint(float t)
{
  return new PVector(
    getLevel(t, 0) + 0.5,
    getLevel(t, 1) + 0.5
  );
}

void setup()
{
  size(512, 512, P2D);
  colorMode(HSB, 1);
  smooth(4);
  noFill();
  
  frameRate = fps;
  
  loadWaveform("../Assets/Waveform.dat");
}

void draw()
{
  background(1);

  final float t0 = (float)((frameCount - 1) % totalFrames) / fps;
  final float sx = width / 2;
  final float sy = height / 2;
  
  {
    final int res = width / 4;
    final float dt = 1.0 / (fps * res);

    float y = getLevel(t0, 0);
    float t = t0 + dt;
    
    for (int i = 1; i < res; i++)
    {
      float n = getLevel(t, 0);
      line(i      * 2, (y + 0.5) * sy,
          (i + 1) * 2, (n + 0.5) * sy);
      t += dt;
      y = n;
    }
  }
  
  translate(sx, 0);
  
  {
    final int res = (int)(1.0 / fps * sampleRate);
    final float dt = 1.0 / (fps * res);
  
    float t = t0;
    PVector p = getPoint(t);
    
    for (int i = 0; i < res; i++)
    {
      PVector n = getPoint(t);
      line(p.x * sx, p.y * sy,
           n.x * sx, n.y * sy);
      t += dt;
      p = n;
    }
  }

  translate(-sx, sy);
  
  {
    final int res = (int)(1.0 / fps * sampleRate);
    final float dt = 1.0 / (fps * res);
  
    float t = t0;
    PVector p = getPoint(t);
    
    for (int i = 0; i < res; i++)
    {
      PVector n = getPoint(t);
      n = PVector.lerp(p, n, 0.05);
      line(p.x * sx, p.y * sy,
           n.x * sx, n.y * sy);
      t += dt;
      p = n;
    }
  }
  
  translate(sx, 0);
  
  {
    final int res = 50;
    final float dt = 1.0 / (fps * res);
  
    float t = t0;

    for (int i = 0; i < res; i++)
    {
      PVector p1 = getPoint(t - dt);
      PVector p2 = getPoint(t);
      PVector p3 = getPoint(t + dt);
      PVector p4 = getPoint(t + dt * 2);
      curve(p1.x * sx, p1.y * sy,
            p2.x * sx, p2.y * sy,
            p3.x * sx, p3.y * sy,
            p4.x * sx, p4.y * sy);
      t += dt;
    }
  }
  
  //if (frameCount <= totalFrames) saveFrame();
}