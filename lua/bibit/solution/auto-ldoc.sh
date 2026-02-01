#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
while inotifywait -e MODIFY $(find . -type f -name '*.lua'); do ldoc .; done
