* 执行以下命令导入nessus镜像
    ```
    docker load < nessus6.11.1.tar  //导入到本地docker
    docker tag 57 nessus:6.11.1  //设置tag
    ```
* 由于6.11.1版本扫描只能出一台机器的结果,因此推荐使用7.0.3版本的,通过python脚本一样是能出结果的
* 镜像加载完成之后启动docker镜像
    ```
    docker run -d -p 8834:8834 --name nessus sometheycallme/docker-nessus
    ```
* 访问http://www.tenable.com/products/nessus-home 输入邮箱获取activation code(这里可以使用[临时邮箱](http://24mail.chacuo.net/))
* 浏览器输入https://ip:8834 进入Nessus的web界面,激活方式选择offline,离线激活,会得到一串challenge code
* 然后访问https://plugins.nessus.org/v2/offline.php 输入刚获得的challenge code和我们用邮箱申请的activation code(注意每个activation code只能使用一次)
* 成功后我们就会得到license和plugins包(all-2.0.tar.gz 大小199MB),浏览器输入license后成功激活
* 复制下载的all-2.0.tar.gz到内网Nessus安装的服务器上,登陆Nessus → Setting → Software Update 右上角 Manual Software Update
* 选择 "Upload your own plugin archive",下一步,选择刚上传的all-2.0.tar.gz文件，等一段时间就升级好了。可以看看CPU使用率，升级插件是CPU使用率较高，降下来后升级就是完成了。
  
参考:[Nessus离线安装及升级插件](https://www.jianshu.com/p/6a1ec52d216a) | [nessus-docker](https://github.com/fuku2014/nessus-docker)