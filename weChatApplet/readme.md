# 微信小程序

## 介绍

微信小程序，英文名Mini Program，是一种不需要下载安装即可使用的应用，微信内被便捷地获取和传播，同时具有出色的使用体验。

**官方网址：**https://mp.weixin.qq.com/cgi-bin/wx?token=&lang=zh_CN

![image-20230427150838044](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230427150838044.png) 

**接入流程**

![image-20230428204204789](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230428204204789.png) 

## 开通账号

### 注册账号

注册地址：https://mp.weixin.qq.com/wxopen/waregister?action=step1&source=mpregister&token=&lang=zh_CN

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230414170840130.png"/> 

![image-20230427154314074](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230427154314074.png) 

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230414171337750.png" /> 

 <img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230414171721848.png" />

 

### 完善信息

登录小程序后台：https://mp.weixin.qq.com/  两种登录方式选其一即可

完善小程序信息、小程序类目

![image-20230414183509233](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230414183509233.png)

### 查看秘钥

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230414172922919.png"/> 

## 体验小程序

### 安装工具

下载地址： https://developers.weixin.qq.com/miniprogram/dev/devtools/stable.html 

资料中已提供，安装后，微信扫码登录`微信开发者工具`

![image-20230427155434307](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230427155434307.png)  

### 创建项目

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230424180700065.png"/> 

![image-20230424182315783](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230424182315783.png) 

### 域名校验

开发阶段，小程序发出请求到后端的Tomcat服务器，若不勾选，请求发送失败。 

![image-20230427152649614](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230427152649614.png) 

### 工具布局

模拟器（手机端显示效果）

编辑器（编写代码）

调试器（浏览器开发者工具）

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20221203213108317.png"/> 

### 目录结构

![image-20230427153248121](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230427153248121.png) 

每个小程序页面主要由四个文件组成：

| 文件类型 | 必须 | 作用       |
| -------- | ---- | ---------- |
| js       | 是   | 页面逻辑   |
| wxml     | 是   | 页面结构   |
| json     | 否   | 页面配置   |
| wxss     | 否   | 页面样式表 |

### 运行小程序

小程序主要是由前端开发人员完成，模板中已经完成了基础代码，这里我们直接演示

- 点击预览按钮
- 手机扫码体验小程序

![image-20230425230429670](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230425230429670.png)

### 发布小程序

小程序的代码都已经开发完毕，要将小程序发布上线，让所有的用户都能使用到这个小程序：

![image-20230427155147903](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230427155147903.png) 

进到微信公众平台，打开版本管理页面：

![image-20230414213713875](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230414213713875.png)

==把代码上传到微信服务器就表示小程序已经发布了吗？==

需提交审核，变成审核版本，审核通过后，进行发布，变成线上版本。

一旦成为线上版本，这就说明小程序就已经发布上线了，微信用户就可以在微信里面去搜索和使用这个小程序了。

## 导入苍穹

### 导入工程

将小程序代码，复制到自己的工作空间中，然后导入到开发者工具

![image-20230508103856603](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230508103856603.png)  

![image-20230508104203155](https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20230508104203155.png)  

AppID：使用自己的AppID

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20221204210011364.png"/> 

### 查看项目结构

主体的文件:app.js app.json app.wxss  项目的页面比较多，主要存放在pages目录。

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20221204210739195.png"/> 

### 修改配置

因为小程序要请求后端服务，需要修改为自己后端服务的ip地址和端口号==(默认不需要修改)==

common-->vendor.js-->搜索(ctrl+f)-->baseUrl

<img src="https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/image-20221204211239035.png"/> 

