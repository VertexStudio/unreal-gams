FROM ubuntu:bionic

RUN apt-get update && apt-get -y install \
    build-essential \
    git-core \
    autoconf \
    sudo \
    wget \
    libboost-all-dev \
    unzip \
    gdb \
    xterm

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g ${GROUP_ID} sim && \
    useradd -l -u ${USER_ID} -g sim sim && \
    echo "sim:sim" | chpasswd && adduser sim sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV SIM_ROOT=/sim

USER sim

ENV MPC_ROOT=$SIM_ROOT/gams/MPC
ENV EIGEN_ROOT=$SIM_ROOT/gams/eigen
ENV CAPNP_ROOT=$SIM_ROOT/gams/capnproto
ENV MADARA_ROOT=$SIM_ROOT/gams/madara
ENV GAMS_ROOT=$SIM_ROOT/gams
ENV VREP_ROOT=
ENV CORES=8
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MADARA_ROOT/lib:$GAMS_ROOT/lib:$VREP_ROOT:$CAPNP_ROOT/c++/.libs
ENV PATH=$PATH:$MPC_ROOT:$VREP_ROOT:$CAPNP_ROOT/c++

WORKDIR $SIM_ROOT

CMD /bin/bash
