# Clipsh

A minimal clipboard manager

## Dependencies

[xclip](https://github.com/astrand/xclip) or adapt `$CLIP_CMD`

## Daemonise

```
watch -n1 ./clip.sh
```

## Usage

```
FOLDER=/dev/shm/clipshed
NB_CHARS_PREVIEW=160

# fzy
cat $(find $FOLDER -type f | xargs -I{} sh -c 'print $(head -c160 {}) |\
sed -r "s/\n/ /g" ; echo " {}"' | fzy | awk '{print $NF}') | xclip -selection c

# rofi
cat $(find $FOLDER -type f | xargs -I{} sh -c 'echo -n $(head -c160 {}) |\
sed -r "s/[\n\r]/ /g" ; echo " {}"' | rofi -dmenu | awk '{print $NF}') |\
xclip -selection c
```

## Configuration

Adapt `$CLIP_CMD` if you want to keep history of all selected text too
