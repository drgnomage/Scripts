#!/bin/bash

for name in FIRST SECOND THIRD FOURTH FIFTH; do
    declare "$name"="$(( $i + 1 ))${!name}"
    printf '%s\n' "${!name}"
done
