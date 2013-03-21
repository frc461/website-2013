git log --format=format:"%at|%an: %s" --reverse > commit_log
gource -s 1 \
       --hide filenames,dirnames \
       --file-idle-time 0 \
       --max-file-lag 1 \
       -e .1 \
       --caption-file commit_log \
       --caption-size 10 \
       --caption-duration 2 \
       -1920x1080 \
       -r 3p0 \
       -o - \
       .. \
| \
ffmpeg -y \
       -r 40 \
       -f image2pipe \
       -vcodec ppm \
       -i - \
       -vcodec libvpx \
       -b 20000K \
       gource.webm
