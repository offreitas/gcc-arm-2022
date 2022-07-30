FROM ubuntu:22.04
LABEL maintainer "Otavio Freitas"

CMD ["/bin/bash"]

# Build arg: Preferred text editor (default = vim)
ARG	EDITORPKG=vim

RUN apt-get update && apt-get install -y
RUN apt-get install -y vim
RUN apt-get install -y texinfo
RUN apt-get install -y libgmp-dev
RUN apt-get install -y libexpat-dev
RUN apt-get install -y wget
RUN apt-get install -y build-essential
RUN apt-get install -y gdb-multiarch

RUN dpkg --add-architecture i386 \
	&& apt-get install -y libc6-dev libc6 libc6-i386-cross \
	&& apt-get install -y libstdc++6 libstdc++6-i386-cross \
	&& apt-get install -y libx11-6 \
	&& apt-get install -y libncurses5 libncurses5-dev \
	&& apt-get install -y qemu-system-arm

RUN cd /\
	&& wget https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz

# RUN cd / \
# 	&& wget https://ftp.gnu.org/gnu/gdb/gdb-12.1.tar.gz

# RUN tar -xf gdb-12.1.tar.gz \
# 	&& rm -rf gdb-12.1.tar.gz
	
# RUN	cd gdb-12.1 \
# 	&& mkdir build \
# 	&& cd build \
# 	&& sh ../configure --prefix=/usr/local/gdb-12.1 \
# 					   --enable-target=all \ 
# 					   --enable-tui \
# 	&& make \
# 	&& make -C gdb install

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

