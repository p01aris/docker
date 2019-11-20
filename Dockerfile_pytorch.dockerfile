# Build Tensorflow with support cuDNN v5
ARG UBUNTU_VERSION=18.04

ARG ARCH=
ARG CUDA=10.1
ARG CUDNN=cudnn7
FROM nvidia/cuda${ARCH:+-$ARCH}:${CUDA}-${CUDNN}-devel-ubuntu${UBUNTU_VERSION} as base

#FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

MAINTAINER LU, ZHENG <zheng.lu.1985@outlook.com>

ARG DEBIAN_FRONTEND=noninteractive 
# Install essential Ubuntu packages, Oracle Java 8,
# and upgrade pip
RUN apt-get update &&\
    apt-get install -y software-properties-common \
                       build-essential \
                       cmake \
                       git \
                       wget \
                       vim \
                       curl \
                       zip \
                       zlib1g-dev \
                       unzip \ 
                       pkg-config \
                       libblas-dev \
                       liblapack-dev \
                       python-dev \
                       python3-dev \
                       python3-pip \
                       python3-tk \
                       python3-wheel \
                       swig &&\
    ln -s /usr/bin/python3 /usr/local/bin/python &&\
    ln -s /usr/bin/pip3 /usr/local/bin/pip &&\
    pip install --upgrade pip &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install anaconda for python 3.6
#RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
#    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
#    rm ~/anaconda.sh && \
#    echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc


# Set timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


# Set locale
ENV LANG C.UTF-8 LC_ALL=C.UTF-8


# Initialize workspace
RUN mkdir /workspace

WORKDIR /src

# Install Bazel from source
ARG BAZEL_VER=0.21.0
ENV BAZEL_VER $BAZEL_VER
ENV BAZEL_INSTALLER bazel-$BAZEL_VER-installer-linux-x86_64.sh
ENV BAZEL_URL https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VER/$BAZEL_INSTALLER
RUN wget $BAZEL_URL &&\
    wget $BAZEL_URL.sha256 &&\
    sha256sum -c $BAZEL_INSTALLER.sha256 &&\
    chmod +x $BAZEL_INSTALLER &&\
    ./$BAZEL_INSTALLER &&\
    rm /src/*
# Set pip3 mirrors
RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple 
# Install essential Python packages
RUN pip3 --no-cache-dir --default-timeout=1000 install \
         numpy \
         matplotlib \
         scipy \
         pandas \
         jupyter \
         jupyterlab \
         scikit-learn \
         seaborn \
         torch \
         torchvision
