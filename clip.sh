#!/usr/bin/env bash

clip(){ xclip -selection c -o; }
# clip(){ xclip -o; } # use this to watch any selection
FOLDER="/dev/shm/clipsh"
[ ! -d "$FOLDER" ] && mkdir $FOLDER
FILENAME="${FOLDER}/$(date +%s)"

# compute clip MD5
CLIP_MD5=$(clip | md5sum | awk '{print $1}')
echo "$CLIP_MD5"

# last clip is still the clipboard
LAST_CLIP=$(find ${FOLDER} -type f | head -1)

# first clip ?
[ -z "$LAST_CLIP" ] && clip > "$FILENAME" && echo "wrote first clip" && exit 0
LAST_CLIP_MD5=$(md5sum "$LAST_CLIP" |  awk '{print $1}')

[ "$LAST_CLIP_MD5" == "$CLIP_MD5" ] && echo "clip didnt change" && exit 0

# check if already clipped
ALREADY_CLIPPED=$(find $FOLDER -type f -print0 | xargs -0 md5sum |  grep "$CLIP_MD5")
echo "already clipped: $ALREADY_CLIPPED"

if [ ! -z "$ALREADY_CLIPPED" ]; then
  echo 'promoting duplicate'
  mv "$(echo "$ALREADY_CLIPPED"| awk '{print $2}')" "$FILENAME"
else
  echo "adding new clip"
  clip> "$FILENAME"
fi
