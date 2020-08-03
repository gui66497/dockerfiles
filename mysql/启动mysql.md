启动命令
```$xslt
docker run --name mysql5.6 --restart always -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root \
-v /home/soc/mysql/data:/var/lib/mysql -d mysql:5.6 --lower_case_table_names=1
```
参数说明
- --name mysql5.6: 指定运行容器名称
- --restart always: 容器意外退出后自动重启
- -p 3306:3306: 映射主机 3306 端口到容器 3306 端口
- -e MYSQL_ROOT_PASSWORD=12345: 指定 mysql root 密码，该参数是为必须的
- -v /home/vagrant/mysql5.7/data:/var/lib/mysql: mysql 数据持久化，主机 /home/vagrant/mysql5.7/data 目录挂载到容器 /var/lib/mysql 目录
- --lower_case_table_names=1 设置大小写不敏感

docker-compose版本
```$xslt
version: '3'
services:
  mysql:
    image: mysql:5.6
    container_name: mysql
    restart: always
    ports:
      - 3306:3306
    command:
      --lower_case_table_names=1
    volumes:
      - /home/soc/mysql/data:/var/lib/mysql
    environment:
       MYSQL_ROOT_PASSWORD: root
```
