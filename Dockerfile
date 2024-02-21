FROM ubuntu:22.04

MAINTAINER NA ZHU <nz2274@cumc.columbia.edu>

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential wget  git \
		libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev libpthread-stubs0-dev && \
	apt-get clean && apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

## T1K
RUN git clone https://github.com/mourisl/T1K.git && \
cd T1K && \
sed -i 's/char nucToNum/signed char nucToNum/g' *.cpp && \
sed -i 's/char nucToNum/signed char nucToNum/g' *.hpp && \
sed -i 's/char nucToNum/signed char nucToNum/g' *.h && \ 
wget https://github.com/samtools/htslib/releases/download/1.15.1/htslib-1.15.1.tar.bz2 && \
tar -jxf htslib-1.15.1.tar.bz2 && \
htslib=1 make
ENV PATH=${PATH}:/usr/src/T1K
