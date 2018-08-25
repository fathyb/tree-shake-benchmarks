#!/bin/bash

if ! yarn $@; then
    echo "Yarn exited with a non-zero exit status"
fi
