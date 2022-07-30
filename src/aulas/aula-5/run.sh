#!/bin/bash
arm-elf-gcc -Wall -Wextra -g $1 ; arm-elf-gdb --command=cmd.txt a.out