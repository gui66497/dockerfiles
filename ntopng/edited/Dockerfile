FROM ubuntu:16.04
MAINTAINER fgt<gui66497@163.com>

RUN apt-get update
RUN apt-get -y -q install wget lsb-core
RUN wget http://apt-stable.ntop.org/16.04/all/apt-ntop-stable.deb
RUN dpkg -i apt-ntop-stable.deb

RUN apt-get clean all
RUN apt-get update
RUN apt-get -y -q install pfring nprobe ntopng ntopng-data n2disk cento

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

#替换默认redis配置文件，修改了端口
COPY redis.conf /etc/redis/redis.conf

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /tmp/run.sh
RUN chmod +x /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]