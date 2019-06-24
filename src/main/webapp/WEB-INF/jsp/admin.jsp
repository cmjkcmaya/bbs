<!doctype html>

<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>论坛后台管理</title>
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <meta http-equiv="Cache-Control" content="no-siteapp" />
        <link rel="stylesheet" href="/statics/css/font.css">
        <link rel="stylesheet" href="/statics/css/xadmin.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="/statics/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="/statics/js/xadmin.js"></script>
        <script type="text/javascript" src="/statics/js/jquery.js"></script>
    </head>
    <body onload="onload()" class="index">
        <!-- 顶部开始 -->
        <div class="container">
            <div class="logo">
                <a href="/bbs/index">去论坛主页</a></div>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <a href="/bbs/user/home">
                        <img src="/statics/images/avatar/${u.head}" class="layui-nav-img">
                        ${u.username}
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="/bbs/user/set" target="_blank">基本设置</a></dd>
                        <dd><a href="/bbs/user/post" target="_blank">我的帖子</a></dd>
                        <hr style="margin: 5px 0;">
                        <dd><a href="/bbs/logout" style="text-align: center;">退出</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
        </div>
        <!-- 顶部结束 -->
        <!-- 中部开始 -->
        <!-- 左侧菜单开始 -->
        <div class="left-nav">
            <div id="side-nav">
                <ul id="nav">
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="用户管理">&#xe6b8;</i>
                            <cite>用户管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <li>
                                <a id="a" onclick="xadmin.add_tab('用户列表','/bbs/admin/user')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>用户列表</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('版主申请审核','/bbs/admin/banzhu')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>版主申请审核</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('禁言、封禁管理','/bbs/admin/forbid')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>禁言、封禁管理</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('用户举报信息处理','/bbs/admin/report')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>用户举报信息处理</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('群发站内信','/bbs/admin/qunfa')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>群发站内信</cite></a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="版块管理">&#xe723;</i>
                            <cite>版块管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <li>
                                <a onclick="xadmin.add_tab('版块列表','/bbs/admin/board')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>版块列表</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('版块合并','/bbs/admin/hb')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>版块合并</cite></a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="帖子管理">&#xe723;</i>
                            <cite>帖子管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <li>
                                <a onclick="xadmin.add_tab('帖子列表','/bbs/admin/post')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>帖子列表</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('公告帖','/bbs/admin/ggt')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>公告帖</cite></a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('精品帖审核','/bbs/admin/good')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>精品帖审核</cite></a>
                            </li>
                        </ul>
                    </li>



                </ul>
            </div>
        </div>
        <!-- <div class="x-slide_left"></div> -->
        <!-- 左侧菜单结束 -->
        <!-- 右侧主体开始 -->
        <div class="page-content">
            <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
                <ul class="layui-tab-title">
                    <li class="home">
                        <!--<i class="layui-icon">&#xe68e;</i>我的桌面</li>--></ul>
                <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
                    <dl>
                        <dd data-type="this">关闭当前</dd>
                        <dd data-type="other">关闭其它</dd>
                        <dd data-type="all">关闭全部</dd></dl>
                </div>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <iframe src='' frameborder="0" scrolling="no" class="x-iframe"></iframe>
                    </div>
                </div>
                <div id="tab_show"></div>
            </div>
        </div>
        <div class="page-content-bg"></div>
        <style id="theme_style"></style>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->
        <script>
function onload(){

$("#a").click();

}


        </script>
    </body>

</html>