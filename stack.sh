#!/bin/bash
PARAMETERS="$@"

# Locate our script
SOURCE="${BASH_SOURCE[0]}"

while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  STACKDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done

STACKDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# CD into homestead
cd $STACKDIR"/homestead"

case $1 in
install)
    composer install
    ;;
self-update)
    cd ../
    git pull
    composer install
    ;;
selfupdate)
    stack self-update
    ;;
edit)
    open ./Homestead.yaml
    ;;
modify)
    subl .
    ;;
self)
    subl ../
    ;;
which)
    echo $STACKDIR
    ;;
project)
    subl $STACKDIR
    ;;
open)
    open .
    ;;
readme)
    open ../readme.md
    ;;
*)
    vagrant $PARAMETERS
    ;;
esac
