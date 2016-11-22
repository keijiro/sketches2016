rem ffmpeg.exe -f image2 -r 20 -i screen-%%04d.tif -y -pix_fmt yuv420p -an video.mp4
ffmpeg.exe -f image2 -r 20 -i screen-%%04d.tif -y -vf palettegen=max_colors=16 palette.png
ffmpeg.exe -f image2 -r 20 -i screen-%%04d.tif -y -i palette.png -filter_complex "null[x];[x][1:v]paletteuse" -r 20 anim.gif
