ffmpeg \
-t 10 -f lavfi -i color=c=white:s=480x480 -pix_fmt yuv420p \
-i ben.png \
-filter_complex \
"[0:v][1:v]overlay=0:0" \
aaa.mp4 -y
