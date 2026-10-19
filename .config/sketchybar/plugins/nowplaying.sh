#!/bin/sh

# Reads system Now Playing (any app, e.g. Supersonic) via JXA + MediaRemote.
# nowplaying.js prints "Track - Artist <glyph>"; the glyph goes in icon (Nerd
# Font) and the rest in label (SF Pro), since SF Pro has no Nerd Font glyphs.

OUT="$(osascript -l JavaScript "$CONFIG_DIR/plugins/nowplaying.js" 2>/dev/null)"

if [ -z "$OUT" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

sketchybar --set "$NAME" drawing=on icon="${OUT##* }" label="${OUT% *}"
