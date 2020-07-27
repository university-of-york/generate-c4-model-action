#!/bin/bash

echo "Hello $1"

echo "$GITHUB_WORKSPACE"

echo "$2"

java -version

/structurizr-cli/structurizr.sh

time=$(date)
echo "::set-output name=time::$time"
