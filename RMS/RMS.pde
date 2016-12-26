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

float calculateRMS(float time, float duration)
{
  final int count = waveform[0].length;

  final int i1 = min(floor( time             * sampleRate), count - 2);
  final int i2 = min(floor((time + duration) * sampleRate), count - 2);

  float sqsum = 0;
  for (int i = i1; i < i2; i++)
    sqsum += sq(waveform[0][i]);

  return sqrt(sqsum / (i2 - i1));
}

void setup()
{
  size(512, 512, P3D);
  colorMode(HSB, 1);
  smooth(4);
  
  frameRate = fps;
  
  loadWaveform("../Assets/Waveform.dat");
}

void draw()
{
  final float time = (float)((frameCount - 1) % totalFrames) / fps;
  final float t01  = (float)((frameCount - 1) % totalFrames) / totalFrames;
  final float rms = calculateRMS(time, 1.0 / fps);

  background(1);
  camera(0, 0, 1, 0, 0, 0, 0, 1, 0); // !workaround!

  // draw waveform
  
  ortho();
  translate(-width / 2, -height / 2);
  stroke(0.3);

  final float dtdx = 1.0 / (fps * width);
  for (int x = 0; x < width; x += 4)
  {
    final float y = getLevel(time + dtdx * x, 0) + 0.5;
    line(x, height / 2, x, y * height);
  }
  
  // draw animated cubes

  perspective(0.5, 1, 0.01, 100);
  camera(
    0, 0.5, 30 + sin(t01 * PI * 2) * 6,
    0, 0.5, 0,
    0, 10, 0
  );
  rotateX(-0.6 + cos(t01 * PI * 4) * 0.2);
  rotateY(0.2 + sin(t01 * PI * 2) * 0.6);
  stroke(0);

  final int columns = 20;
  for (int ix = 0; ix < columns; ix++)
  {
    final float x = ix - (columns - 1.0) / 2;
    for (int iy = 0; iy < columns; iy++)
    {
      final float y = iy - (columns - 1.0) / 2;
      final float d = sqrt(x * x + y * y);
      
      float s = max(rms * 20 - d * 0.33, 0);
      s = 1 - abs(1 - s % 2);
      s = s * 0.8 + 0.1;
      
      pushMatrix();
      translate(x, 0, y);
      box(s, s, s);
      popMatrix();
    }
  }
  
  //if (frameCount <= totalFrames) saveFrame();
}