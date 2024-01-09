if open -Ra "Godot_mono" 2>/dev/null; then
  export GODOT4="/Applications/Godot_mono.app/Contents/MacOS/Godot"
elif open -Ra "Godot" 2>/dev/null; then
  export GODOT4="/Applications/Godot.app/Contents/MacOS/Godot"
fi
