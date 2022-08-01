FROM ubuntu:22.04
LABEL maintainer "Otavio Freitas"

CMD ["/bin/bash"]

# Install arm-elf
ADD files/i386.list /etc/apt/sources.list.d/
ADD files/bu-2.15_gcc-3.4.3-c-c++-java_nl-1.12.0_gi-6.1.tar.bz2 /

RUN sed 's/^deb http/deb [arch=arm64] http/' -i '/etc/apt/sources.list'

RUN apt-get update && apt-get install -y
RUN apt-get install -y build-essential

RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y \
		libc6:i386 \
		libncurses5:i386 \
		libstdc++6:i386 \
		libx11-6:i386 \
		qemu-system-arm:arm64 \
		gcc-arm-none-eabi:arm64 \
		gdb-arm-none-eabi:arm64 \
		gcc-arm-linux-gnueabi:arm64 \
		gdb

# Create non-root "student" user
RUN	useradd -mG sudo student && mkdir -p /etc/sudoers.d && \
	echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo_nopasswd && \
	mkdir -p /home/student/src

# Login as "student" user on startup
COPY	entrypoint.sh	/
ENTRYPOINT	["/entrypoint.sh"]

# Run commands when starting GDB
ADD	files/.gdbinit	/home/student/.gdbinit/

# Fix ARM highlight syntax for VIM
ADD	files/asm.vim	/home/student/.vim/syntax/

# Configure user Bash
ADD	files/.bashrc	/
RUN	cat < /.bashrc >> /home/student/.bashrc

