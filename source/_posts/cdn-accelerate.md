---
title: 使用JSDelivr加速加载Github资源
date: 2019-12-24 09:40:10
categories:
- 工具
tags:
- cdn
- github
---

## 什么是CDN

CDN(Content Delivery Network)是指内容分发网络，也称为内容传送网络。CDN是构建在现有网络基础之上的智能虚拟网络，依靠部署在各地的边缘服务器，通过中心平台的负载均衡、内容分发、调度等功能模块，使用户就近获取所需内容，降低网络拥塞，提高用户访问响应速度和命中率。

CDN的基本原理是广泛采用各种缓存服务器，将这些缓存服务器分布到用户访问相对集中的地区或网络中，在用户访问网站时，利用全局负载技术将用户的访问指向距离最近的工作正常的缓存服务器上，由缓存服务器直接响应用户请求。

## 为什么使用CDN

由于我在Github挂载的个人静态博客网站所需加载的诸如图片、音乐文件都需要在Github存储库获取，而Github是美国的，国内访问比较耗时，可以测试一下

```cmd
C:\Users\Cirike>ping github.com

正在 Ping github.com [192.30.253.113] 具有 32 字节的数据:
来自 192.30.253.113 的回复: 字节=32 时间=292ms TTL=50
来自 192.30.253.113 的回复: 字节=32 时间=290ms TTL=50
来自 192.30.253.113 的回复: 字节=32 时间=291ms TTL=50
来自 192.30.253.113 的回复: 字节=32 时间=290ms TTL=50

192.30.253.113 的 Ping 统计信息:
    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
往返行程的估计时间(以毫秒为单位):
    最短 = 290ms，最长 = 292ms，平均 = 290ms

C:\Users\Cirike>ping www.baidu.com

正在 Ping www.baidu.com [14.215.177.38] 具有 32 字节的数据:
来自 14.215.177.38 的回复: 字节=32 时间=7ms TTL=56
来自 14.215.177.38 的回复: 字节=32 时间=10ms TTL=56
来自 14.215.177.38 的回复: 字节=32 时间=7ms TTL=56
来自 14.215.177.38 的回复: 字节=32 时间=9ms TTL=56

14.215.177.38 的 Ping 统计信息:
    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
往返行程的估计时间(以毫秒为单位):
    最短 = 7ms，最长 = 10ms，平均 = 8ms
```

可以看到，访问Github比访问百度需要多经过6个中转路由，且耗时30~40倍，这使得网站加载时获取静态资源时间过长而体验不好，这时可以想到两种解决方法，第一种是直接使用国内服务器存放静态资源，但是贫穷限制了本人选择了第二种方法，使用CDN加速Github资源。

## 构建JSDelivr加速环境

JSDelivr是一款免费的CDN加速产品，可以加速Github和NPM的资源，使用方法也很简单，首先新建一个Github的仓库，用来存储需要存放的静态资源。使用本地Git连接上，然后向Github上传文件，上传之后在Git上面打开资源，此时的连接为

```text
https://github.com/Cirike/cdn.static.resource/blob/master/test.txt
```

而使用JSDelivr加速访问的话只需要修改连接为对应的形式

```text
https://cdn.jsdelivr.net/gh/Cirike/cdn.static.resource@master/test.txt
```

即

```text
https://cdn.jsdelivr.net/gh/{Github用户名}/{Github仓库名}@{版本名}/{仓库下资源路径}
```

此时访问资源的速度就直线上升了。

其中版本名可以在Github当前仓库的Release

![](https://cdn.jsdelivr.net/gh/Cirike/cdn.static.resource@master/blog_img/1577154346.jpg)



![](https://cdn.jsdelivr.net/gh/Cirike/cdn.static.resource@master/blog_img/1577154432.jpg)



![](https://cdn.jsdelivr.net/gh/Cirike/cdn.static.resource@master/blog_img/1577154462.jpg)

输入版本号点击Publish release发布后，@对应的版本号就能访问对应的资源了。