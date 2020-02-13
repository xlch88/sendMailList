# SendMailList
一个too simple的邮件队列，post访问send.php添加邮件到队列，然后cron运行run.php执行队列。

使用PHP+MySQL+PHPMailer实现。

使用计c划r任o务n驱动，建议每3秒运行一次。



特点：

* 简·单·粗·暴
* 使用WTFPL开源，宁爱咋地咋地，毫无限制（除了PHPMailer遵守原本协议）
* 支持多个秘钥鉴权
* 支持对发件箱进行分组，每次从组里随机抽取一个发件箱
* 支持限制某个密钥用某个组



发送邮件流程：
1. 从数据库拉取状态为未发送(status = 0)的邮件
2. 设置状态为发送中(status = 1)
3. 从组里随机取出发件箱
4. 发送邮件
5. 记录发件结果
6. goto 1



# 安装

将sql文件导入到你的数据库，然后配置config.php设置数据库信息。

修改send_mail表数据，添加你的邮箱。

修改send_auth表数据，配置你的秘钥以及该秘钥允许使用的组。

请享受 :)



# 添加待发送邮件到队列

post访问

``` send.php?id=[秘钥id]&secret=[秘钥]```

参数如下：

```gid``` ：使用的发送组

```target``` ：接收的邮箱

```subject``` ：邮件标题

```body``` ：邮件内容

```altBody``` ：邮件简化内容

如发送一封测试邮件，大概是这样的：

```POST /send.php?id=1&secret=12345678901234567890123456789012```

POST数据:

```gid=0&target=408214421@qq.com&subject=测试邮件&body=这是一封测试邮件```



# 执行队列

推荐使用linux自带的cron执行，间隔3秒一次。

生成时间推荐用这个工具：http://cron.qqe2.com/

```php run.php >/dev/null```
