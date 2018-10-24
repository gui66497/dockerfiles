FROM centos:7.2.1511
MAINTAINER fgt <guitang.fang@zzjunzhi.com>

ENV DAQ_VERSION 2.0.6
ENV SNORT_VERSION 2.9.8.3

RUN yum -y install rsyslog
RUN yum -y install epel-release
RUN yum -y install \
 https://www.snort.org/downloads/archive/snort/daq-${DAQ_VERSION}-1.centos7.x86_64.rpm \
 https://www.snort.org/downloads/archive/snort/snort-${SNORT_VERSION}-1.centos7.x86_64.rpm

RUN ln -s /usr/lib64/snort-${SNORT_VERSION}_dynamicengine \
       /usr/local/lib/snort_dynamicengine && \
    ln -s /usr/lib64/snort-${SNORT_VERSION}_dynamicpreprocessor \
       /usr/local/lib/snort_dynamicpreprocessor

#配置syslog发送
COPY ./rsyslog.conf /etc/rsyslog.conf

#重启syslog 会报Failed to get D-Bus connection: Operation not permitted无法重启服务
#因此此镜像存在问题
#RUN systemctl restart rsyslog.service

#清理
RUN yum clean all && \
    rm -rf /var/log/* || true \
    rm -rf /var/tmp/* \
    rm -rf /tmp/*

RUN /usr/sbin/snort -V

CMD [ "snort", "-c", "/home/snort/etc/snort.conf" ]