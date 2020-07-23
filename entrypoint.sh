#!/bin/bash

echo "Hello $1"

java -version

./structurizr-cli/structurizr.sh

time=$(date)
echo "::set-output name=time::$time"
