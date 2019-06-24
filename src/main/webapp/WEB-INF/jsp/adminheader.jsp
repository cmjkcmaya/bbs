<%--
  Created by IntelliJ IDEA.
  User: 綾
  Date: 2019/4/20
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" href="#">
            <img src="/statics/images/logo.png" alt="layui"  width=160px height=45px >
        </a>
        <ul class="layui-nav fly-nav layui-hide-xs">
            <li class="layui-nav-item ">
                <a href="/bbs/index"><i class="iconfont icon-jiaoliu"></i>首页</a>
            </li>
            <li class="layui-nav-item ">
                <a href="/bbs/index"><i class="iconfont icon-jiaoliu"></i>查找帖子</a>
            </li>
            <li class="layui-nav-item ">
                <a href="/bbs/index"><i class="iconfont icon-jiaoliu"></i>查找用户</a>
            </li>
        </ul>

        <ul class="layui-nav fly-nav-user">

            <!-- 未登入的状态 -->
            <li class="layui-nav-item">
                <a class="iconfont icon-touxiang layui-hide-xs" href="/bbs/login"></a>
            </li>
            <li class="layui-nav-item">
                <a href="/bbs/login">登入</a>
            </li>
            <li class="layui-nav-item">
                <a href="/bbs/register">注册</a>
            </li>

            <!-- 登入后的状态 -->
            <!--
            <li class="layui-nav-item">
              <a class="fly-nav-avatar" href="javascript:;">
                <cite class="layui-hide-xs">贤心</cite>
                <i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：layui 作者"></i>
                <i class="layui-badge fly-badge-vip layui-hide-xs">VIP3</i>
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg">
              </a>
              <dl class="layui-nav-child">
                <dd><a href="../user/set.html"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
                <dd><a href="../user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
                <dd><a href="../user/home.html"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
                <hr style="margin: 5px 0;">
                <dd><a href="" style="text-align: center;">退出</a></dd>
              </dl>
            </li>
            -->
        </ul>
    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">


        <div class="fly-column-right layui-hide-xs"> <!--搜索 -->

            <!--<a href="../../statics/html/jie/add.html" class="layui-btn">发表新帖</a>-->
        </div>

    </div>
</div>
</body>
</html>
