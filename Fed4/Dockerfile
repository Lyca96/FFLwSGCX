#FROM ubuntu:latest
FROM gramineproject/gramine:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopencv-dev \
    unzip \
    git

RUN apt-get install -y \
    curl

RUN apt-get install -y \
    vim

COPY FastFederatedLearning-main /app

RUN git clone -b v1.3.2 --single-branch --depth 1 https://github.com/USCiLab/cereal.git /cereal
ENV CEREAL_HOME="/cereal/include"

RUN git clone -b DistributedFF --single-branch --depth 1  https://github.com/fastflow/fastflow.git /fastflow
WORKDIR /fastflow/ff/distributed/loader
RUN sed -i s/-std=c++20/-std=c++17/g Makefile
ENV FF_HOME="/fastflow"
ENV PATH="$FF_HOME/ff/distributed/loader:$PATH"

WORKDIR /

RUN apt-get install -y \
    curl

ENV TORCHURL="https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-2.0.0%2Bcpu.zip"
RUN curl "$TORCHURL" -o torch.whl
RUN unzip torch.whl 
RUN rm -f torch.whl

ENV TORCH_HOME="/libtorch"

RUN git clone -b pure_c_reproducible --single-branch --depth 1 https://github.com/alpha-unito/FastFederatedLearning.git /ffl

RUN mkdir /ffl/build
WORKDIR /ffl/build
RUN cmake ../
RUN make -j $(getconf _NPROCESSORS_ONLN)


