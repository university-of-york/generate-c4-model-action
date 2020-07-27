#!/bin/bash

echo "Generating C4 model..."

export input="$GITHUB_WORKSPACE/$2"
export inputdir="$(dirname "$input")"
export outputdir="$GITHUB_WORKSPACE/build/generate-c4-model/" # TODO convert to optional input parameter

echo "Input file: $input"
echo "Input location: $inputdir"
echo "Output location: $outputdir"

# TODO check input exists
if [ ! -f "$input" ]
then
    echo "Input file '$input' not found"  >&2
    exit 1
fi

echo "Exporting Structurizr dsl to PlantUML format..."

/structurizr-cli/structurizr.sh export -w "$input" -f "plantuml"

if [$? -ne 0]
then
    echo "An error occurred when attempting to generate PlantUML files" >&2
    exit $?
fi

ls *.puml

if [$? -ne 0]
then
    echo "Did not generate any PlantUML files" >&2
    exit $?
fi

echo "Moving PlantUML files to '$outputdir'..."

mkdir -p "$outputdir"

mv "$inputdir"/*.puml "$outputdir"

echo "Generating .png images..."

plantuml "$outputdir"/*.puml

ls -la "$outputdir"

echo "Finished"

time=$(date)
echo "::set-output name=time::$time"
