git log --format=format:"%at|%an: %s" --reverse > commit_log
gource -s 1 \
       --hide filenames,dirnames,mouse,progress \
       --file-idle-time 0 \
       --max-file-lag 1 \
       -e .1 \
       --caption-file commit_log \
       --caption-size 10 \
       --caption-duration 2 \
       -1920x1080 \
       -r 60 \
       -o - \
       .. \
| \
ffmpeg -y \
       -r 60 \
       -f image2pipe \
       -vcodec ppm \
       -i - \
       -vcodec libx264 \
       -preset ultrafast \
       -crf 1 \
       -threads 0 \
       -bf 0 \
       gource.mp4
# ffmpeg -y \
#        -r 30 \
#        -f image2pipe \
#        -vcodec ppm \
#        -i - \
#        -vcodec libvpx \
#        -b 1G \
#        gource.webm
