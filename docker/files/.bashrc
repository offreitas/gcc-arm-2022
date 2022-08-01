
# Configure user Bash
export PS1="\e[01;33m\u\e[00m:\e[01;33m\w\e[00m$ "
export PATH=$PATH
PATH="$PATH:/gnuarm-3.4.3/bin"
# arm-elf
alias arm="arm-linux-gnueabi-gcc -S"
alias gcc="arm-linux-gnueabi-gcc -Wall -Wextra -g"
alias gdb="gdb -tui --command=/home/student/.gdbinit/default"
alias e7t="gdb -tui --command=/home/student/.gdbinit/evaluator7t"
# arm-none-eabi
alias eabi-gcc="arm-none-eabi-gcc -c -mcpu=arm926ej-s -Wall -Wextra -g"
alias eabi-as="arm-none-eabi-as -c -mcpu=arm926ej-s -g"
alias eabi-ld="arm-none-eabi-ld"
alias eabi-bin="arm-none-eabi-objcopy -O binary"
alias eabi-gdb="gdb -tui --command=/home/student/.gdbinit/default"
alias eabi-qemu="gdb -tui --command=/home/student/.gdbinit/qemu"
# qemu
alias qemu="qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel"

cd /home/student/src
