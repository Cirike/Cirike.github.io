---
title: hexo_after
date: 2019-12-26 15:49:55
categories:
- 工具
tags:
- hexo
---

## 关于写作

在根目录下打开git bash

```git
$ hexo new [layout] "title"

```

`layout`为新建.md文件的布局格式，不写默认为post布局，在根目录的scaffolds文件夹里默认有`draft.md`，`page.md`，`post.md`三种布局格式

```markdown
title: {{ title }}
date: {{ date }}
tags:

```

`title`：文章显示标题，{{title}}接受hexo new时指定的title；

`date`：文章生成时间，{{date}}为hexo new时的时间；

`tags`：文章标签，可以为文章指定多个标签。

可以在scaffolds文件夹里新增自定义布局格式的.md文件，并在新建hexo new的时候指定对应名称为新建文件的layout，也可以直接修改里面的三个文件。

根目录下的`_config.yml`是hexo的主配置文件，# Writing注释下的配置为写作的配置，修改`default_layout`的值就可以切换hexo new的布局风格。

最后，`new`一个新文章文件时，会在根目录的`source`文件夹下生成对应layout的文件夹（文件夹不存在时），并在对应文件夹里生成指定标题的新文件 `title.md`，里面的内容与layout对应。

## 关于主题

hexo支持使用不同风格的主题以个性化自己的网站。可以自己修改也可以使用别人写好的。

[hexo theme官网](https://hexo.io/themes/)

可以在官网找到自己喜欢的theme，然后找到对应的git clone地址，在主目录下进入`theme`目录并打开git bash

```git
$ git clone #对应git clone链接

```

clone done之后就会在theme文件夹里生成一个主题的文件夹，回到根目录打开`_config.yml`配置文件，修改`theme:`后的属性为预切换主题文件夹的名称即可切换主题。

对应主题的相关配置操作可以查看该主题文件夹里面的`README.md`。

该文件夹下的`_config.yml`为该主题的配置文件，可以修改里面的配置以适应自己的需求。

`layout`文件夹为主题的整体布局文件，修改里面的文件即可修改自己的页面布局，使用的时`ejs`语法。

`source`文件夹为主题的资源文件夹，存放了一些主题所使用的`图片`以及`js`、`css`代码，也可以修改里面的文件以适应自己的需求

这些是一般主题基本具有的目录结构，当然根据主题设计者的风格也可能有区别，需要时再根据具体情况了解。

## 关于背景音乐

我想要的背景音乐是自己本地上传的，所以我是在对应的`ejs`文件添加自启动`javascript`脚本

```ejs
<script>
    
window.onload = function(){
	
		//存入所需歌曲的src地址
        var arr = [/*可以存多个音频文件地址，以“，”分割*/];
        var myAudio = new Audio();
        myAudio.preload = true;
        myAudio.controls = true;
		 //随机获取歌曲的src
		myAudio.src = arr[getRandom(arr.length)];
		
        myAudio.addEventListener('ended', playEndedHandler, false);
        myAudio.play();
        document.getElementById("audioBox").appendChild(myAudio);
        myAudio.loop = false;//禁止循环，否则无法触发ended事件
        function playEndedHandler(){
            myAudio.src = arr[getRandom(arr.length)];
            myAudio.play();
        }
		
		// 生成随机下标
		function getRandom(length){
			
			var num = Math.random();
			num = num * (length);
			num = Math.floor(num);
			return num;
		}
    }
</script>

<div id="audioBox" style="position:absolute; bottom: 0; right: 0;"></div>

```

当然也可以引用音乐播放软件的一些`iframe`。

## 关于备份与移植

由于hexo部署到Github时，Github的仓库只存了hexo转化好的网站文件，即根目录的`.deploy_git`文件夹下的内容，`.deploy_git`是hexo g&hexo d是产生的部署到Github是产生的。`public`文件夹内容也一样，不过这时本地运行hexo s时本地访问时网站的根路径。

总之，为了防止数据丢失和多PC操作，可以把整个文件夹存在Github上。可以在Github新建一个文件夹，因为本来就是相同的project，我就直接在该博客部署的Github仓库新建了一个分支。

![alt 图片](https://cdn.jsdelivr.net/gh/Cirike/cdn.static.resource@master/blog_img/1577352230.jpg)

在Find or create a branch...搜索hexo即可创建hexo分支。创建完成之后，在本地新建一个临时文件夹，再在clone or download复制git链接克隆到本地，克隆完在本地删除文件夹里除了`.git`以外的所有文件。之后打开git bash

```git
$ git add .
$ git commit -m "update"
$ git push origin master:hexo

```

这就更新将`Github`的`hexo`分支清空了，这时再将`.git`文件夹复制到博客文件夹根目录下，这样就把`hexo`分支与本地博客文件夹建立了链接。

这时再在博客文件夹下打开git bash

```git
$ git add .
$ git commit -m "update"
$ git push origin master:hexo

```

就成功将博客主文件夹提交到`Github`仓库的`hexo`分支了。

## 关于快捷部署

在windows系统下，可以编写一个`.bat`批处理文件

```bat
::重新部署hexo至github
call hexo clean
call hexo g
call hexo d

::提交更新至github
call git add .
call git commit -m "update"
call git push origin master:hexo

```

以后只需要打开这个这个`.bat`文件就可以部署和推送仓库一步完成。