final int fps = 24;
final int totalFrames = fps * 4;
final float deltaTime = 1.0 / fps;
final int sampleRate = 44100;

byte[] wav;

float readLevel(float t, int ch)
{
  float offs = t * sampleRate;
  int offs_i = floor(offs);
  float mp = offs - offs_i;
  
  int i = offs_i * 4 + ch * 2;
  
  float s1 = (float)(wav[i    ] + wav[i + 1] * 256) / 65536;
  float s2 = (float)(wav[i + 4] + wav[i + 5] * 256) / 65536;

  return lerp(s1, s2, mp);
}

void setup()
{
  size(512, 512, P2D);
  colorMode(HSB, 1);
  frameRate = fps;
  wav = loadBytes("../Assets/Waveform.dat");
}

void draw()
{
  int fnum = (frameCount - 1) % totalFrames;
  float time = (float)fnum / fps;
  
  background(1);
  
  float t = time;
  float dtdx2 = deltaTime * 2 / width;
  float y1 = (readLevel(time, 0) + 0.5) * height;
  
  for (int x = 2; x < width; x += 2)
  {
    t += dtdx2;
    float y = (readLevel(t, 0) + 0.5) * height;
    line(x - 2, y1, x, y);
    y1 = y;
  }
}