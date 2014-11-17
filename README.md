GuaiGuitar-IOS
==============

小乖看谱的IOS版本APP

项目说明
=====
小乖看谱是一款想要改变吉他谱阅览现状的APP，期望涵盖ios,android,wp,html5各个平台，并且最终成为一个开源的开放的非盈利性的吉他谱分享wiki社区。  

包括项目愿景以及吉他谱JSON数据格式等，请到此查看项目主页：[https://github.com/YuhangGe/GuaiGuitar](https://github.com/YuhangGe/GuaiGuitar)。

目前IOS的APP也才处于初始开发阶段。欢迎爱好吉他的IOS开发者加入！

模块设计
=====

各个模块和文件对应的功能说明

GuaiGuitar
-----
App的主逻辑模块，包括IOS的界面相关设计

Js
----
对IOS的CGContext进行封装，使得代码写起来尽可能跟html5的Canvas一致，方便日后将功能移植到Html5以及其它平台的版本上。

Doc
----
吉他谱的数据格式

Render
-----
吉他谱的渲染逻辑

Editor
-----
吉他谱编辑器的主逻辑

Event
-----
事件处理模块

Util
-----
util模块

