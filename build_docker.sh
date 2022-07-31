#!/bin/bash

GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build --no-cache -t offreitas/gcc-arm-2022 $GITDIR/docker
