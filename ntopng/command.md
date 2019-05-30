### 区别解释
origin版本表示没做任何修改的版本,edited版修改了以来的redis服务的端口,由原来的6379改为了6377,如果es开启了安全则要在最后加user:password验证信息
### 命令
#### origin
```
docker run --net=host -t -p 3000:3000 --restart=always --name ntopng fang/ntopng \
-i eth0 -F "es;ntopng;ntopng-%Y.%m.%d;http://192.168.1.188:9200/_bulk;"
```
#### edited
```
docker run --net=host -t -p 3000:3000 --restart=always --name ntopng fang/ntopng \
-i eth0 -F "es;ntopng;ntopng-%Y.%m.%d;http://192.168.1.188:9200/_bulk;" \
-r localhost:6377
```
#### 加密
```
docker run --net=host -t -p 3000:3000 --restart=always --name ntopng fang/ntopng \
-i eth0 -F "es;ntopng;ntopng-%Y.%m.%d;http://192.168.1.188:9200/_bulk;elastic:zzjz1234;"
```

### 命令详解
#### --net=host
host 模式,在这个模式下，docker 不会为容器创建单独的网络 namespace，而是共享主机的 network namespace，也就是说：容器可以直接访问主机上所有的网络信息.

#### --restart=always
宿主机重启,容器也会跟着重启,如果不做设置容器是不会自动重启的

docker run --net=host -t -p 3000:3000 --restart=always --name ntopng fang/ntopng \
-i eth0 -F "es;ntopng;ntopng-%Y.%m.%d;http://192.168.1.188:9200/_bulk;elastic:zzjz1234;"