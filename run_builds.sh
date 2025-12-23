#!/bin/bash

TASK=$1
FILE=$2
MODEL=$3

if [ -z "$TASK" ] || [ -z "$FILE" ] || [ -z "$MODEL" ]; then
  echo "Usage: $0 <task_type> <links_file>"
  exit 1
fi

if [ ! -f "$FILE" ]; then
  echo "Error: File '$FILE' not found."
  exit 1
fi

while IFS= read -r LINK; do
  # skip empty lines or commented lines
  [[ -z "$LINK" || "$LINK" =~ ^# ]] && continue

  echo "Processing link: $LINK"
  python llm4build-pipeline.py --task "$TASK" --link "$LINK" --output_folder "output" --model "$MODEL"

  echo "---------------------------------------------------"
done < "$FILE"
