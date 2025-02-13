FROM ubuntu AS base

#install al dependencies for the RISCV toolchain
RUN apt-get update && apt-get -y install \
device-tree-compiler \
autoconf \
automake \
autotools-dev \
curl \
python3 \
python3-pip \
libmpc-dev \
libmpfr-dev \
libgmp-dev \
gawk \
build-essential \
bison \
flex \
texinfo \
gperf \
libtool \
patchutils \
bc \
zlib1g-dev \
libexpat-dev \
ninja-build \
git \
cmake \
libglib2.0-dev \
libusb-1.0-0-dev \
pkg-config \
wget

#set the riscv to the path path and create environment variables
ENV RISCV="/opt/riscv"
ENV PATH="$RISCV/bin:$PATH"
ENV N_CORES=15

#install risc-v cross compiler (newlib)
RUN git clone https://github.com/riscv/riscv-gnu-toolchain \
&& cd riscv-gnu-toolchain \
&& git checkout 2025.01.20 \
&& ./configure --prefix=${RISCV} --enable-multilib \
&& make -j ${N_CORES}

#install RISCV proxy kernel and boot loader
RUN git clone https://github.com/riscv-software-src/riscv-pk.git \
&& cd riscv-pk \
&& mkdir build \
&& cd build \
&& ../configure --prefix=${RISCV} --host=riscv64-unknown-elf --with-arch=rv64gc_zifencei \
&& make -j ${N_CORES} \
&& make install

#install spike
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim.git \
&& cd riscv-isa-sim \
&& mkdir build \
&& cd build \
&& ../configure --prefix=${RISCV} \
&& make -j ${N_CORES} \
&& make install

RUN git clone https://github.com/riscv/riscv-tests \
&& cd riscv-tests \
&& git submodule update --init --recursive \
&& autoconf \
&& ./configure --prefix=${RISCV}/target \
&& make -j ${N_CORES} \
&& make install

ARG USER_ID
ARG GROUP_ID
RUN groupadd -g ${GROUP_ID} cascader && \
    useradd -u ${USER_ID} -g cascader -m cascader
