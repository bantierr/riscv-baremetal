#!/bin/sh

# Build the Docker container
docker build\
 --build-arg USER_ID="$(id -u)"\
 --build-arg GROUP_ID="$(id -g)"\
 -t riscvtools:v1\
 .
