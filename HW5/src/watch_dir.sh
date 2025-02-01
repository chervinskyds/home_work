#!/bin/bash
watch_dir="/home/adminedx/watch"

while true; do
  inotifywait -m -e create "$watch_dir" | while read -r directory events filename; do
    full_path="$directory$filename"
    echo "New file: $filename"
    cat "$full_path"
    mv "$full_path" "${full_path}.back"
    echo "Fila change name $filename.back"
  done
done
