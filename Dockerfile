FROM ubuntu-upstart

RUN apt-get update && \
	apt-get install -y \
	bison \
	build-essential \
	flex \
	git \
	gsl-bin \
	libgsl0-dev \
	libpng12-dev \
	libjpeg-dev \
	libilmbase-dev \
	libopenexr-dev \
	wget \
	vim \
	libtiff5-dev \
	openexr-viewers && \
	cd /

RUN git clone https://github.com/ydnality/pbrt-v2-spectral.git \
	/pbrt/v2-spectral/ && \
	cd /pbrt/v2-spectral/src && make
RUN git clone https://github.com/mmp/pbrt-v2.git \
	/pbrt/v2/ && \
	cd /pbrt/v2/src && make
RUN apt-get install -y software-properties-common && \
	add-apt-repository ppa:george-edison55/cmake-3.x && \
	apt-get update && \
	apt-get install -y cmake && \
	git clone --recursive https://github.com/mmp/pbrt-v3.git \
	/pbrt/v3/
RUN cd /pbrt/v3 && cmake . && make -j4

RUN apt-get clean && \
    apt-get autoclean && \
	apt-get autoremove

VOLUME /pbrt-out

