### command
```
docker run --net=host -t -p 3000:3000 --restart=always --name ntopng fang/ntopng \
-i eth0 -F "es;ntopng;ntopng-%Y.%m.%d;http://192.168.1.188:9200/_bulk;"
```

### 解释
#### --net=host
host 模式,在这个模式下，docker 不会为容器创建单独的网络 namespace，而是共享主机的 network namespace，也就是说：容器可以直接访问主机上所有的网络信息.

#### --restart=always
宿主机重启,容器也会跟着重启,如果不做设置容器是不会自动重启的

