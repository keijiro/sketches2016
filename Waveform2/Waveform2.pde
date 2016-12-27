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

void setup()
{
  size(512, 512, P2D);
  colorMode(HSB, 1);
  smooth(4);
  noFill();
  
  frameRate = fps;
  
  loadWaveform("../Assets/Waveform.dat");
}

PVector getPoint(float t)
{
  return new PVector(
    (getLevel(t, 0) + 0.5) * width,
    (getLevel(t, 1) + 0.5) * height
  );
}

void draw()
{
  background(1);
  blendMode(SUBTRACT);

  final int points = 48;
  final int lines = 48;
  final int divisor = 4;
  
  float t0 = (float)((frameCount - 1) % totalFrames) / fps;
  final float dt = 1.0 / (fps * points);

  for (int il = 0; il < lines; il++)
  {
    stroke(0.1, 0.3, (1 - abs(1 - il * 2.0 / lines)) * 0.13);

    float t = t0;

    for (int ip = 0; ip < points; ip++)
    {
      PVector p1 = getPoint(t - dt);
      PVector p2 = getPoint(t);
      PVector p3 = getPoint(t + dt);
      PVector p4 = getPoint(t + dt * 2);
      curve(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
      t += dt;
    }
    
    t0 += 1.0 / (fps * lines * points * divisor);
  }

  //if (frameCount <= totalFrames) saveFrame();
}