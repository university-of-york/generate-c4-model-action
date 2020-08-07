#!/bin/bash

set -e

echo "Generating C4 model"

source="$GITHUB_WORKSPACE/$1"
source_dir="$(dirname "$INPUT")"
tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
target_dir="$GITHUB_WORKSPACE/$2"

if [ ! -f "$source" ]; then
    echo "Structurizr DSL file '$source' not found"  >&2
    exit 1
fi

echo "[params]
source: $source
target dir: $target_dir"

echo "Exporting Structurizr DSL to PlantUML format"

/structurizr-cli/structurizr.sh export -w "$source" -f "plantuml"

if [ $? -ne 0 ]; then
    echo "An error occurred when attempting to export to PlantUML format" >&2
    exit $?
fi

ls "$source_dir"/*.puml >/dev/null

if [ $? -ne 0 ]; then
    echo "Did not generate any PlantUML files" >&2
    exit $?
fi

echo "Moving PlantUML files to '$tmp_dir'"

mkdir -p "$tmp_dir"
mv "$source_dir"/*.puml "$tmp_dir"

echo "Generating .png images"

plantuml "$tmp_dir"/*.puml

echo "Moving C4 images to '$target_dir'"

mkdir -p "$target_dir"
mv "$tmp_dir"/*.png "$target_dir"

ls -la "$target_dir"

echo "Finished"

exit 0
