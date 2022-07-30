#!//bin/bash
qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel $1.bin
