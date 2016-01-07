FROM python:3.5

MAINTAINER EngageNExecute <code@engagenexecute.com>

ENV OPENCV_VERSION 3.1.0

# Install packages.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        locales \
        git-core \
        sudo \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjasper-dev \
        libavformat-dev \
        libopencv-dev \
        libjpeg-dev \
        libtiff-dev \
        libpng12-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libgtk2.0-dev \
        libatlas-base-dev \
        gfortran \
        && apt-get -y clean all \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /


RUN wget https://github.com/Itseez/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip ${OPENCV_VERSION}.zip \
    && mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
    && cd /opencv-${OPENCV_VERSION}/cmake_binary \
    && cmake .. \
    && make install \
    && rm /${OPENCV_VERSION}.zip \
    && rm -r /opencv-${OPENCV_VERSION}

# Set UTF-8 as locales
RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

# ENV UTF-8
ENV LC_ALL C.UTF-8
