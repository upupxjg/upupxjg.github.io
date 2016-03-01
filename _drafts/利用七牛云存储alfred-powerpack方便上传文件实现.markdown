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

