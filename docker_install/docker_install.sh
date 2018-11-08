#!/bin/bash
#安装docker
dockercount=`rpm -qa|grep docker|wc -l`
if [ $dockercount == 0 ]; then
    cd /opt/docker_install
    rpm -Uvh epel-release-6-8.noarch.rpm
    rpm -ivh lxc-libs-1.0.11-1.el6.x86_64.rpm 
    rpm -ivh lua-filesystem-1.4.2-1.el6.x86_64.rpm 
    rpm -ivh lua-alt-getopt-0.7.0-1.el6.noarch.rpm 
    rpm -ivh lua-lxc-1.0.11-1.el6.x86_64.rpm 
    rpm -ivh lxc-1.0.11-1.el6.x86_64.rpm 
    rpm -ivh libcgroup-0.40.rc1-24.el6_9.x86_64.rpm
    rpm -ivh docker-io-1.7.1-2.el6.x86_64.rpm
    chkconfig docker on
    service docker start
fi

#检测docker服务是否启动
dockerpid=`ps -ef|grep /usr/bin/docker|grep -v grep|awk '{print $2}'`
if [ "$dockerpid" != "" ]; then
        echo "docker is runing!"
else
        service docker start
fi

#安装docker-compose
if which docker-compose 2>/dev/null; then
  echo "docker-compose exists!"
else
  echo "nope, no docker-compose installed."
  cp ./docker-compose/docker-compose-Linux-x86_64_1.5.2 /usr/bin/docker-compose
  chmod +x /usr/bin/docker-compose
  docker-compose --version
fi