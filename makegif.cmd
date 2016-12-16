ffmpeg.exe -f image2 -r %1 -start_number 1 -i screen-%%04d.tif -y -vf palettegen=max_colors=%2 palette.png
ffmpeg.exe -f image2 -r %1 -start_number 1 -i screen-%%04d.tif -y -i palette.png -filter_complex "scale=%3:-1:flags=lanczos[x];[x][1:v]paletteuse" -r %1 anim.gif
