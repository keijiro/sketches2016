ffmpeg.exe -f image2 -r 24 -i screen-%%04d.tif -y -pix_fmt yuv420p -an video.mp4
ffmpeg.exe -f image2 -r 24 -i screen-%%04d.tif -y -vf palettegen=max_colors=8 palette.png
ffmpeg.exe -f image2 -r 24 -i screen-%%04d.tif -y -i palette.png -filter_complex "null[x];[x][1:v]paletteuse" -r 24 anim.gif
