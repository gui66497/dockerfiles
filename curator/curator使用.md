#### 介绍
Elasticsearch Curator通过以下方式帮助您策划或管理您的Elasticsearch索引和快照：
- 从集群中获取索引（或快照）的完整列表，作为可操作列表
- 迭代用户定义的过滤器列表，根据需要逐步从此可操作列表中删除索引（或快照）
- 对用户定义的动作列表中的项目执行各种操作(包括Create Index、Delete Indices、Reindex、Snapshot等)
#### 使用
curator的命令行语法如下：
````
curator [--config CONFIG.YML] [--dry-run] ACTION_FILE.YML
````
- CONFIG.YML：配置ES的基本信息
- ACTION_FILE.YML：具体的执行脚本
- dry-run:curator将尽可能接近地模拟ACTION_FILE.YML中的动作，而不实际进行任何更改
下面是具体的使用例子: 
curator.yml:
````
client:
  hosts:
    - 192.168.1.188
  port: 9200
  url_prefix:
  use_ssl: False
  certificate:
  client_cert:
  client_key:
  ssl_no_validate: False
  http_auth:
  timeout: 30
  master_only: False

logging:
  loglevel: INFO
  logfile:
  logformat: default
  blacklist: ['elasticsearch', 'urllib3']
````
deleteIndecies.yml:
````
actions:
  1:
    action: delete_indices
    description: >-
      删除超过120天的索引（基于索引名称），用于nessus-
   前缀索引。如果过滤器没有导致错误，请忽略错误
   可操作的索引列表（ignore_empty_list）并彻底退出.
    options:
      ignore_empty_list: True
      disable_action: False
    filters:
    - filtertype: pattern
      kind: prefix
      value: nessus-
    - filtertype: age
      source: name
      direction: older
      timestring: '%Y.%m.%d'
      unit: days
      unit_count: 120
````

**最后执行以下命令即可运行(实际使用时记得删除--dry-run)** 

```
docker run --rm -v /opt/curator-docker:/curator-docker fang/curator --dry-run /curator-docker/deleteIndecies.yml
```

其它功能可以前往官网查看[官方文档](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html)或[使用实例](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/ex_delete_indices.html)

