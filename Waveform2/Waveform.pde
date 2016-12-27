class Waveform
{
  int sampleRate;

  private float[][] buffers;

  Waveform(String path)
  {
    final byte[] raw = loadBytes(path);
    final int len = raw.length / 4;
    
    buffers = new float[2][len];
    
    int offs = 0;
    for (int i = 0; i < len; i++)
    {
      buffers[0][i] = (float)(raw[offs + 0] + raw[offs + 1] * 256) / 65536;
      buffers[1][i] = (float)(raw[offs + 2] + raw[offs + 3] * 256) / 65536;
      offs += 4;
    }

    sampleRate = 44100; // just guessing!
  }

  float getLevel(float time, int channel)
  {
    final int len = buffers[channel].length;
  
    final float p = time * sampleRate;
    final int p_ = floor(p);
    final int i = constrain(p_, 0, len - 2);
    
    final float v1 = buffers[channel][i    ];
    final float v2 = buffers[channel][i + 1];
    
    return lerp(v1, v2, p - p_);
  }
}