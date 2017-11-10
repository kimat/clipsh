# Clipsh

A minimal clipboard manager

## Usage

- Run the daemon using : `watch -n1 ./clip.sh` : every second,
  clipboard content will be saved
- use `./lsclips` to build a command to replace your
  current clipboard with a previous one with a previous one
  use a ready made one from `examples` folder

## Configuration

- adapt `clip()` in `clipsh` if you want to keep history of all selected text too
- adapt `$FOLDER` in `clipsh` if you want clips to be written to disk
- adapt `clip()` in `clipsh` || `examples/*` if you wan't to replace [xclip](https://github.com/astrand/xclip)
