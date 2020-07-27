#!/bin/bash

echo "Generating C4 model..."

export input="$GITHUB_WORKSPACE/$2"
export inputdir="$(dirname "$input")"
export output="$GITHUB_WORKSPACE/build/generate-c4-model/" # TODO convert to optional input parameter

echo "Input file: $input"
echo "Input directory: $inputdir"
echo "Output location: $output"

# TODO check input exists
if [ ! -f "$input" ]
then
    echo "Input file '$input' not found"  >&2
    exit 1
fi

echo "Exporting Structurizr dsl to PlantUML format..."

/structurizr-cli/structurizr.sh export -w "$input" -f "plantuml"

ls *.puml

if [$? -ne 0]
then
    echo "Did not generate any PlantUML files" >&2
    exit $?
fi

echo "Moving plantuml files to '$output'..."

mkdir -p "$output"

mv "$inputdir"/*.puml "$output"

ls -la "$output"

echo "Finished"

time=$(date)
echo "::set-output name=time::$time"
