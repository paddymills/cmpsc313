#!/bin/bash

# create a switch case on the first argument matching 'run' and 'init'
case "$1" in
    run)
        # assert that there are 3 arguments
        if [ "$#" -ne 3 ]; then
            echo "Usage: $0 run <src_dir> <src_file>"
            exit 1
        fi

        # compile and run the file in the src directory
        spim -file src/$2/$3.asm
        ;;
    init)
        # assert that there are 3 arguments
        if [ "$#" -ne 3 ]; then
            echo "Usage: $0 init <src_dir> <src_file>"
            exit 1
        fi

        cp src/{template,$2/$3}.asm
        ;;
    *)
        echo "Usage: $0 {run|init}"
        exit 1
        ;;
esac