#!/bin/bash

IMAGE="$(docker ps -q -f ancestor=offreitas/gcc-arm-2022)"

if [[ $IMAGE ]] ; then
	docker exec -ti --user student $IMAGE bash
else
	if [[ "$1" ]] ; then
		SRCDIR="$( cd $1 && pwd )"
	else
		GITDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
		SRCDIR="$GITDIR/src"
	fi

	if [[ "$2" ]]; then
		docker run --rm -ti -v "$SRCDIR":/home/student/src --device="$2":/dev/ttyS0 offreitas/gcc-arm-2022
	else
		docker run --rm -ti -v "$SRCDIR":/home/student/src offreitas/gcc-arm-2022
	fi
fi
