FROM centos:6.7
MAINTAINER fgt <guitang.fang@zzjunzhi.com>

ENV DAQ_VERSION 2.0.6
ENV SNORT_VERSION 2.9.8.3
ENV DNET_VERSION 1.12

RUN yum -y install yum-plugin-ovl
RUN yum -y install epel-release
RUN yum -y install rsyslog
RUN yum -y install gcc gcc-c++ flex libpcap* pcre* bison libpcre-devel zlib-devel wget tar

#指定工作目录
WORKDIR /opt

#编译安装libdnet
RUN wget https://github.com/dugsong/libdnet/archive/libdnet-${DNET_VERSION}.tar.gz \
    && tar xvfz libdnet-${DNET_VERSION}.tar.gz \
    && cd libdnet-libdnet-${DNET_VERSION} \
    && ./configure; make; make install

#编译安装daq
RUN wget https://www.snort.org/downloads/archive/snort/daq-${DAQ_VERSION}.tar.gz \
    && tar xvfz daq-${DAQ_VERSION}.tar.gz \
    && cd daq-${DAQ_VERSION} \
    && ./configure; make; make install

#编译安装snort
RUN wget https://www.snort.org/downloads/archive/snort/snort-${SNORT_VERSION}.tar.gz \
    && tar xvfz snort-${SNORT_VERSION}.tar.gz \
    && cd snort-${SNORT_VERSION} \
    && ./configure; make; make install

#配置syslog发送
COPY ./rsyslog.conf /etc/rsyslog.conf

#重启syslog 重启无效
#RUN service rsyslog start

#清理
RUN yum clean all && \
    rm -rf /var/log/* || true \
    rm -rf /var/tmp/* \
    rm -rf /tmp/*

RUN snort -V

#ENTRYPOINT service rsyslog restart && /usr/local/bin/snort
CMD service rsyslog restart && /usr/local/bin/snort