#!/usr/bin/env bash

CLIP_CMD="xclip -selection -c -o"
# CLIP_CMD="xclip -o" # use this to watch any selection
FOLDER="/dev/shm/clipsh"
[ ! -d "$FOLDER" ] && mkdir $FOLDER
FILENAME="${FOLDER}/$(date +%s)"

# compute clip MD5
CLIP_MD5=$($CLIP_CMD | md5sum | awk '{print $1}')
echo "$CLIP_MD5"

# last clip is still the clipboard
LAST_CLIP=$(find ${FOLDER} -type f | head -1)

# first clip ?
[ -z "$LAST_CLIP" ] && xclip -selection c -o > "$FILENAME" && echo "wrote first clip" && exit 0
LAST_CLIP_MD5=$(md5sum "$LAST_CLIP" |  awk '{print $1}')

[ "$LAST_CLIP_MD5" == "$CLIP_MD5" ] && echo "clip didnt change" && exit 0

# check if already clipped
ALREADY_CLIPPED=$(find $FOLDER -type f -0 | xargs -I{} md5sum {} |  grep "$CLIP_MD5")
echo "$ALREADY_CLIPPED"

if [ ! -z "$ALREADY_CLIPPED" ]; then
  echo 'promoting duplicate'
  mv "$(echo "$ALREADY_CLIPPED"| awk '{print $2}')" "$FILENAME"
else
  echo "adding new clip"
  $CLIP_CMD > "$FILENAME"
fi
