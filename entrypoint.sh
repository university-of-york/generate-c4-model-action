#!/bin/bash

echo "Generating C4 model..."

export input="$GITHUB_WORKSPACE/$2"
export output="$GITHUB_WORKSPACE/dist/c4/"

echo "Input location: $input"
echo "Output location: $output"

# TODO check input exists

echo "Exporting Structurizr dsl to PlantUML format..."

/structurizr-cli/structurizr.sh export -w "$input" -f "plantuml"

# TODO check files exist

echo "Moving plantuml files to location '$output'..."

mv "/structurizr-cli/*.puml" "$output"

ls -la "$output"

echo "Finished"

time=$(date)
echo "::set-output name=time::$time"
