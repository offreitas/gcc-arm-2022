#!/bin/bash

GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$*" ]] ; then
	echo docker build -t offreitas/gcc-arm-2022 --build-arg EDITORPKG="$*" $GITDIR/docker
else
	docker build -t offreitas/gcc-arm-2022 $GITDIR/docker
fi
