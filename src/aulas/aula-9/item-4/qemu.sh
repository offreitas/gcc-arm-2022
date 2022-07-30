#!/bin/bash
arm-none-eabi-gdb -tui --command=/home/student/.gdbinit/qemu -se test.elf
