---
title: MacOSX下利用七牛云存储+Alfred workflow方便上传文件
layout: post
categories: [工具]
tags: [七牛,Alfred,Mac]
description: 利用七牛+ALfred workflow，终于可以高效免费的上传文件并获取文件URL了。
---


## 前言

最近开始写blog，找了好久，发现并没有一款方便高效的工具可以支持快速上传文件并生成资源连接的。但是目前各种云存储如此繁华的今天，这个事情想必自己搞定也并非难事，研究了百度云、阿里云等一些大品牌之后发现门槛较高各种贵，偶然间查blog CDN加速的相关问题时，发现了[七牛](https://portal.qiniu.com),提供**10GB**存储空间、**10GB**网络流量和**10w/100w**次put/get调用，个人感觉还是很良心的。
![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160301-0@2x.png)

----

## Alfred

Alfred不做过多介绍，总之很NB就是了。

-----

## 准备工作

1. 七牛云存储帐号
2. Mactonish or Hactonish
3. Alfred + Powerpack
4. 一定的Coding能力

----

## 开搞

### 首先当然是注册帐号，这一步略过

（略）

### 注册完帐号打开开发中心查看自己的ak和sk

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160301-1@2x.png)

然后下载七牛提供的[开发工具](http://developer.qiniu.com/docs/v6/tools/qrsctl.html)，地址如下：  

[http://devtools.qiniu.com/qiniu-devtools-darwin_amd64-current.tar.gz](http://devtools.qiniu.com/qiniu-devtools-darwin_amd64-current.tar.gz)  

解压备用  


### Alfred workflow设置

关于Alfred，可以看一下这篇[知乎贴](https://www.zhihu.com/question/20656680)

下面我们正式开始，首先整理一下思路，要做的第一件事(当然是新建一个workflow）就是选定我们要上传的文件，这个可以通过Alfred的Input->File Filter实现，File Filter会返回选定文件的地址，传给下一个Unit，得到了文件地址，我们需要做的就是调用七牛的qrsctl工具把文件上传，这里我们通过Alfred的Action->Run Script实现，上传完后我们就可以把文件的URL放到剪贴板，同时提醒已经上传成功，这里需要用到Output->copy to clipboard和Output->post notification。  
下面我们就来具体看一下每一个步骤。


### 1. 新建一个workflow

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160302-1@2x.png)

如图，点击*+*，然后按下图输入必要的信息  

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160302-0%402x.png)

### 2. 新建Input -> File Filter

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160302-2@2x.png)

然后切换到第二个选项卡，选择要扫描的文件路径,直接把文件夹拖进去就OK  

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160302-3@2x.png)

点击Save，第一步就完成了，可以呼出Alfred看看是否生效

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160302-4@2x.png)

Bingo!不过目前这个workflow还没有任何的响应，下面我们就来添加一个Action。

### 3. 新建Run Script Action

点击右上角的加号，选择Action->Run Script

![img](http://7u2r8q.com1.z0.glb.clouddn.com/kaizhao1.png)

会出现如下界面

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160316-0@2x.png)

点击*open workflow folder*

将七牛的命令行工具*qrsctl*拷贝到这个目录下面，然后新建一个脚本文件*put2remote*  
并写入以下内容

``` bash
#!/bin/bash

file=$1
if [ -z "$file" ];then
    exit 1
fi
name=${file##*/}

#login to qiniu

if [ -f "$file" ];then
    ./qrsctl login ${yourkey} ${yourkey2}    
    ./qrsctl put xlogcdn $name $1 >/dev/null
    echo $name
else
    echo "file not exist"
    exit 1
fi

```

然后赋予可执行权限，方法是打开终端，在终端输入'chmod +x',然后将*put2remote*文件拖如终端，回车  

然后回到Action的界面，在里面输入以下内容

``` bash

query="{query}"

./put2remote $query

``` 

Run Script Action会讲脚本的标准输出作为返回。

### 4. 获取上传文件的URL

因为七牛这个蛋疼的工具是不会直接把上传的文件的URL返回的，其实URL就是七牛默认给你的域名URL+/+文件名，所以我们首先要知道自己的域名URL是什么。最简单的方法就是去七牛的网站随便上传个图片，打开他，然后在浏览器的地址栏就可以找到URL了，找到url后，我们要做的就是让Alfred帮我们把url和文件名拼起来并且放到剪贴板里，同时提示我们上传成功！

![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160316-1@2x.png)

与新建Action一样，点击+，然后选择Output-> copy to clipboard,然后在得到的页面中输入你的URL+/+{query}，然后save。

### 5. 大功告成

现在我们只需要把刚刚的三个Action串起来，All done！
![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160316-2@2x.png)
![img](http://7u2r8q.com1.z0.glb.clouddn.com/QQ20160316-4@2x.png)


  


赶紧打开Alfred试试吧！


