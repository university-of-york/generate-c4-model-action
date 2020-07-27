#!/bin/bash

echo "Generating C4 model..."

export input="$GITHUB_WORKSPACE/$2"
export inputdir="$(dirname "$input")"
export output="$GITHUB_WORKSPACE/dist/c4/" # TODO convert to optional input parameter

echo "Input file: $input"
echo "Input directory: $inputdir"
echo "Output location: $output"

# TODO check input exists

echo "Exporting Structurizr dsl to PlantUML format..."

/structurizr-cli/structurizr.sh export -w "$input" -f "plantuml"

# TODO check files exist

echo "Moving plantuml files to location '$output'..."

mkdir -p "$output"

mv "$inputdir/*.puml" "$output"

ls -la "$output"

echo "Finished"

time=$(date)
echo "::set-output name=time::$time"
