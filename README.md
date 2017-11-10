# Clipsh

A minimal clipboard manager

## Dependencies

[xclip](https://github.com/astrand/xclip) or adapt `clip()`

## Daemonise

```
watch -n1 ./clip.sh
```

## Usage

```
FOLDER=/dev/shm/clipsh
NB_CHARS_PREVIEW=160
list_clips() { find $FOLDER -type f -print0 | xargs -0 -I{} sh -c "head -c160 {} | tr -d '\n' ; echo ' {}'"; }

# fzy
cat $(list_clips | fzy | awk '{print $NF}') | xclip -selection c

# rofi
cat $(list_clips | rofi -dmenu| awk '{print $NF}') | xclip -selection c
```

## Configuration

- adapt `clip()` if you want to keep history of all selected text too
- adapt `$FOLDER` if you want to keep clips written to disk
