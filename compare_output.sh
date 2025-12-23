#!/bin/bash

FILE=$1           # file with links
OUTPUT_FOLDER=$2  # e.g., historical_builds
BUILD=$3          # e.g., "latest" or empty

if [ -z "$FILE" ] || [ -z "$OUTPUT_FOLDER" ]; then
  echo "Usage: $0 <links_file> <output_folder> [latest]"
  exit 1
fi

mkdir -p output_diff

while IFS= read -r LINK; do
  # skip empty lines or commented lines
  [[ -z "$LINK" || "$LINK" =~ ^# ]] && continue

  echo "Processing link: $LINK"

  repo=$(printf '%s\n' "$LINK" | awk -F/ '{print $5}')
  job_id=$(printf '%s\n' "$LINK" | awk -F/ '{print $NF}')

  # Choose repo_job_id based on BUILD
  if [ "$BUILD" = "latest" ]; then
    repo_job_id="${repo}_master"
  else
    repo_job_id="${repo}_${job_id}"
  fi

  dir1="$OUTPUT_FOLDER/$repo_job_id/out"
  dir2="output/$repo_job_id/out"

  diff_file="output_diff/${repo_job_id}.diff"

  # Start/overwrite diff file for this repo_job_id
  {
    echo "LINK: $LINK"
    echo "repo_job_id: $repo_job_id"
    echo "dir1: $dir1"
    echo "dir2: $dir2"
    echo

    if [ ! -d "$dir1" ]; then
      echo "ERROR: Directory not found: $dir1"
      echo "---------------------------------------------------"
      echo
      continue
    fi

    if [ ! -d "$dir2" ]; then
      echo "ERROR: Directory not found: $dir2"
      echo "---------------------------------------------------"
      echo
      continue
    fi

    files=(Dockerfile run.sh out.json log.txt)

    for f in "${files[@]}"; do
      f1="$dir1/$f"
      f2="$dir2/$f"

      echo "$f"
      echo "----------"

      if [ ! -f "$f1" ] && [ ! -f "$f2" ]; then
        echo "Both missing ($f1 and $f2)"
      elif [ ! -f "$f1" ]; then
        echo "Missing in historical: $f1"
      elif [ ! -f "$f2" ]; then
        echo "Missing in output: $f2"
      else
        # Show unified diff; don't make script fail if diff finds differences
        diff -u "$f1" "$f2" || true
      fi

      echo    # blank line between sections
    done

    echo "---------------------------------------------------"
    echo
  } > "$diff_file"

  echo "Diff written to: $diff_file"
done < "$FILE"
