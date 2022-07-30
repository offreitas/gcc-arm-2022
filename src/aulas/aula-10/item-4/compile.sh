#!/bin/sh

set -x

arm-none-eabi-as -c -mcpu=arm926ej-s -g $1.s -o $1.o
arm-none-eabi-ld -T $1.ld $1.o -o $1.elf
arm-none-eabi-objcopy -O binary $1.elf $1.bin
