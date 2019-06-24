<!DOCTYPE html>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>登录</title>

    <link rel="stylesheet" href="/statics/css/style.css">
    <link rel="stylesheet" href="/statics/layui/css/layui.css">

	
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<div style="height:100px;width:200px">
    <img src="/statics/images/bg.jpg"  alt="banner" />
</div>
<script>

    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
    });
</script>

    <div class="form" style="position:relative">
        <!--登录表单-->
        <div class="form_login" style="position:relative">

            <form action="login" method="post">
                <h1>登录</h1>
                <div style="color:white">${error}</div>
                <div class="form_item">
                    <label for="username">用户名：</label>
                    <input type="text" name="username" id="username" placeholder="请输入用户名" required   maxlength="30" >
                </div>
                <div class="form_item">
                    <label for="password">密码：</label>
                    <input type="password" name="password" id="password" placeholder="请输入密码名" required maxlength="30" >
                </div>
                <div class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <input type="checkbox" name="rem" value="rem" title="记住我的登录状态">
                    </div>
                </div>
                </div>
                <div class="form_item">
                    <input type="submit" value="登录">
                </div>
            </form>
            <div class="info">没有账号？点击<a href="/bbs/register"><span class="switch register_Btn">注册账号</span></a> </div>

        </div>


    </div>


</body>
</html>