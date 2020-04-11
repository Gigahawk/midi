#!/bin/sh

EXPORT_DIR=.export
ARTIST="Fredrik Johansson"

mkdir -p $EXPORT_DIR

get_file_year () {
  local date=$(git log --pretty=format:"%ad" --date=short $1)
  local year=${date%-*-*}
  echo "$year"
}

for f in $(find . -type f -name "*.mid"); do
  filename=$(basename $f)
  songname=${filename%.mid}
  year=$(get_file_year $f)
  echo "Exporting $filename"
  timidity $f -Ow -o - | \
    lame - $EXPORT_DIR/${songname}.mp3 \
    --tt "$songname" \
    --ta "$ARTIST" \
    --tl "$songname" \
    --tn 1 \
    --ty "$year"
done
