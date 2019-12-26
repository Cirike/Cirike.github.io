---
title: 基于hexo和Github搭建个人静态博客
date: 2019-12-17 12:28:28
categories:
- 工具
tags:
- hexo
---

# 基于hexo和Github搭建个人静态博客

## 前言

本文记录基于hexo框架部署到github的个人静态博客搭建过程，博客使用markdown语言编写文章，使得页面非常整洁，读写能力卓越！

## 环境搭建

* **Node.js**

  hexo基于Node.js，安装hexo前需要先安装好node.js。可以在[官网](http://nodejs.cn/download/)下载。

  安装好后按Win+R打开运行，输入cmd打开命令行输入node命令，如果出现

  ```cmd
  Welcome to Node.js (版本号).
  Type ".help" for more information.
  
  ```

  即为安装成功

* **Git**

  接着需要安装git，同样可以前往[官网](https://git-scm.com/)下载最新版本的git。

  安装完成后鼠标右键菜单栏出现Git Gui Here和Git Bash Here即为安装成功。

  ```git
   $ git config --global user.name "yourname"
   $ git config --global user.email youremail
   
  ```

  打开Git Bash做好基础配置。

* **Markdown编辑器**

  该博客系统使用markdown语法编写文章，markdown是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档。

  Markdown是一种语法格式，有多种编辑器可以支持它。

  在这里推荐使用Typora [官网](https://typora.io/)。

* **Hexo**

  接下来可以正式下载Hexo了，Win+R运行打开cmd命令行

  ```cmd
  $ npm i -g hexo
  
  ```

  安装hexo

  如果下载速度太慢可以配置国内cnpm镜像，在cmd配置

  ```cmd
  $ npm install -g cnpm --registry=https://registry.npm.taobao.org
  
  ```

  安装完成后就可以使用cnpm代替npm操作，不同的是走的是国内的镜像，速度会变快

  ```cmd
  $ cnpm i -g hexo
  
  ```

  安装完成之后查看版本号

  ```cmd
  $ hexo -v
  
  ```

  若出现版本号则hexo安装成功。

  ```cmd
  $ cnpm install
  
  ```

  安装依赖

  进入自己的工作区，新建一个文件夹，进入新建文件夹，右键菜单栏点击Git Bash Here打开Git命令行窗口，初始化该文件夹

  ```git
  $ hexo init
  
  ```

  初始化完成后文件夹会出现hexo基本结构文件。

  ```filesystem
  |-- _config.yml
  |-- package.json
  |-- scaffolds
  |-- source
     |-- _posts
  |-- themes
  |-- .gitignore
  |-- package.json
  
  ```

  默认会在source/_posts生成hello-world.md文件，在Git Bash继续输入

  ```git
  $ hexo new "title"
  
  ```

  就会在_posts新生成一个title.md文件，使用Typora打开这个文件就可以写自己的文章了。

  ```cmd
  $ hexo s                   #s为serve
  INFO  Start processing
  INFO  Hexo is running at http://localhost:4000 . Press Ctrl+C to stop.
  
  ```

  这时hexo就部署在了本机，打开浏览器地址栏输入 localhost:4000 就能看到博客界面了。

* **Github**

  打开[Github](https://www.github.com)登录（没有要注册），新建一个仓库，仓库名为 *{yourname}*.github.io， *{yourname}*是Github的账户名称。

  在Github的右上角打开setting打开设置页面，点击选择SSH and GPS keys，点击New SSH key新建一个SSH keys，Title随意起，Key值在C:\users\administrator\找到.ssh文件夹，如果没有打开Git Bash输入

  ```git
  $ ssh-keygen -t rsa -C "email"    #email为git config设置的邮箱
  
  ```
  
  就会生成.ssh文件夹，其中id_rsa.pub文件未生成的ssh公钥，复制里面的内容到上面Github的Key里面，点击Add SSH key就可以建立本机到Github的SSH连接了。
  
  打开_config.yml文件
  
    ```yml
    # Site
    title: Hexo         #修改此处为你的标题，即你网站的主标题
    subtitle: ''		#此处为副标题
    description: ''		#网站描述
    keywords:			
    author: John Doe	#作者名
    language: en		#网站使用语言
    timezone: ''		#网站使用时区
    ```
  
  根据自己需要修改网站信息，接下来配置与Github的联系（重要），此处在yml文件最下面		
  
  ```yml
    deploy:
      type: git
      repo: git@github.com:{yourname}/{yourname}.github.io    #此处{yourname}为			Github用户名，不确定可以打开刚才Github新建的仓库点击Clone or download查看
    branch: master
  ```
  
  继续Git Bash
  
  ```git
    $ cnpm i hexo-deployer-git -save
  ```
  
  安装完成就可以使用命令直接部署到Github仓库去了
  
  ```git
    $ hexo clean
    $ hexo g                  #g为generate
    $ hexo d				  #d为deploy
  ```
  
  Github为你分配的网站地址为 http://{yourname}.github.io
  
  这是Github分配的二级域名，想要一级域名需要购买之后进行配置。
  
  ## **结语**
  
    没想到写一篇文章这么耗时，本章就只介绍基础搭建了，其他之后有空再开新篇吧。

