FROM ubuntu:20.04
LABEL maintainer="Schuyler Smith"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
      ca-certificates \
      build-essential \
      default-jdk default-jre \
      libssl-dev \
      uuid-dev \
      libgpgme11-dev \
      squashfs-tools \
      libseccomp-dev \
      libglib2.0-dev \
      curl wget \
      zip unzip \
      pkg-config \
      git \
      cryptsetup \
      less nano \
      docker.io \
    && apt-get upgrade --yes \
    && apt-get clean

ARG PROGRAM="go"
ARG VERSION="1.20.3"

RUN wget https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz \
  -O ${PROGRAM}.tar.gz \
  && tar -C /usr/local -xzvf ${PROGRAM}.tar.gz \
  && rm -rf ${PROGRAM}.tar.gz 

ENV PATH="${PATH}:/usr/local/${PROGRAM}/bin"

ARG PROGRAM="singularity"
ARG VERSION="3.11.1"

RUN wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz \
  -O ${PROGRAM}.tar.gz \
  && tar -xzf ${PROGRAM}.tar.gz \
  && rm -rf ${PROGRAM}.tar.gz \
  && mv singularity* singularity \
  && cd singularity \
  && ./mconfig \
  && make -C builddir \
  && make -C builddir install

RUN echo "America/Chicago" > /etc/timezone \
  && apt-get install tzdata


CMD ["/bin/bash"]
