#!/usr/bin/env bash

function main() {
    echo 'nasm ' $1 ' -o a.bin -l a.lst'
    `nasm $1 -o a.bin -l a.lst`
}
echo '*****************************************'
main $@
echo '*****************************************'
