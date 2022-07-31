FROM ubuntu:22.04
LABEL maintainer "Otavio Freitas"

CMD ["/bin/bash"]

# Install arm-elf
ADD	files/bu-2.15_gcc-3.4.3-c-c++-java_nl-1.12.0_gi-6.1.tar.bz2	/
ADD files/i386-linux-gnu.tar.gz /lib
# ADD files/sources.list /etc/apt/
ADD files/i386.list /etc/apt/sources.list.d/

RUN sed 's/^deb http/deb [arch=armhf] http/' -i '/etc/apt/sources.list'

RUN dpkg --add-architecture i386 \
	&& apt-get update

RUN apt-get install -f -y \
		libc6:i386 
		libncurses5:i386 \
		libstdc++6:i386 \
		libx11-6:i386

# RUN dpkg --add-architecture i386 \
# 	&& apt-get update
	# # && apt-get install -y libc6-dev libc6 libc6-i386-cross \
	# # && apt-get install -y libstdc++6 libstdc++6-i386-cross \
	# # && apt-get install -y libx11-dev \
	# # && apt-get install -y libncurses5 libncurses5-dev \
	# && apt-get install -y qemu-system-arm \
	# && apt-get install -y gcc-arm-none-eabi \
	# && apt-get install -y gdb-arm-none-eabi \
	# && apt-get install -y gcc-arm-linux-gnueabihf

RUN ln -s /usr/i686-linux-gnu/lib/* /lib/

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

