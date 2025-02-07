#!/bin/sh

dopen() {
    docker run \
      --rm \
      -it \
      -v "$(pwd)":"$(pwd)":Z \
      -w "$(pwd)" \
      --user "$(id -u)":"$(id -g)"\
      riscvtools:v1
}