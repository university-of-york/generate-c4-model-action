#!/bin/bash

set -e

echo "Generating C4 model"

INPUT="$GITHUB_WORKSPACE/$1"
INPUT_DIR="$(dirname "$INPUT")"
BUILD_DIR="$GITHUB_WORKSPACE/$2"
OUTPUT_DIR="$GITHUB_WORKSPACE/$3"

if [ ! -f "$INPUT" ]; then
    echo "Structurizr dsl file '$INPUT' not found"  >&2
    exit 1
fi

echo "[params]
Structurizr dsl file: $INPUT
Structurizr dsl dir: $INPUT_DIR
Build dir: $BUILD_DIR
Output dir: $OUTPUT_DIR"

echo "Exporting Structurizr dsl to PlantUML format"

/structurizr-cli/structurizr.sh export -w "$INPUT" -f "plantuml"

if [ $? -ne 0 ]; then
    echo "An error occurred when attempting to generate PlantUML files" >&2
    exit $?
fi

ls "$INPUT_DIR"/*.puml >/dev/null

if [ $? -ne 0 ]; then
    echo "Did not generate any PlantUML files" >&2
    exit $?
fi

echo "Moving PlantUML files to '$BUILD_DIR'"

mkdir -p "$BUILD_DIR"
mv "$INPUT_DIR"/*.puml "$BUILD_DIR"

echo "Generating .png images"

plantuml "$BUILD_DIR"/*.puml

echo "Moving C4 images to '$OUTPUT_DIR'"

mkdir -p "$OUTPUT_DIR"
mv "$BUILD_DIR"/*.png "$OUTPUT_DIR"

ls -la "$OUTPUT_DIR"

echo "Finished"

exit 0
