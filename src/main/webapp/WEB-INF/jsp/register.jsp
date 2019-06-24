<!DOCTYPE html>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>注册</title>

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
    function  exist(){

        $.post("/bbs/userexist",{username:$("#username").val()},function (msg) {
            console.log(msg);
               if(msg=="false"){
                   $("#error").html("用户已存在");
                   $("#zc").attr("disabled","disabled");
               }else{
                   $("#error").html("");
                   $("#zc").removeAttr("disabled");
               }
        });

    }
    function querenmima() {
        if($("#password").val()!=$("#password1").val()){
            $("#error1").html("输入不一致");
            $("#zc").attr("disabled","disabled");
        }else{
            $("#error1").html("");
            $("#zc").removeAttr("disabled");
        }
    }


</script>


<div class="form" style="position:relative" >

    <!--注册表单-->
    <div class="form_register" style="position:relative">
        <form action="register" method="post">
            <h1>注册</h1>
            <div class="form_item">
                <label for="username">用户名：</label>
                <input type="text" name="username" id="username" placeholder="请输入用户名" required maxlength="30"  oninput="exist()">
            </div>
            <div class="form_item">
            <label id="error"  style="color:white"></label>
            </div>
            <div class="form_item">
                <label for="password">密码：</label>
                <input type="password" name="password" id="password" placeholder="请输入密码" required  maxlength="30" ><br>
            </div>
            <div class="form_item">
            <label></label>
            </div>
            <div class="form_item">
                <label for="password1">确认密码：</label>
                <input type="password" name="password1" id="password1" placeholder="请确认密码" required  maxlength="30"  oninput="querenmima()">
            </div>
            <div class="form_item">
            <label id="error1"  style="color:white"></label>
            </div>
            <div class="form_item">
                <label for="email">电子邮箱：</label>                                                                         <!--[^@]表示“匹配除了@的任意字符”  +匹配前面的子表达式一次或多次。 .匹配除换行符 \n 之外的任何单字符。要匹配 . ，请使用 \.   a-zA-Z最少2次最多6次 。-->
                <input type="email" name="email" id="email" placeholder="请输入电子邮件"  required  maxlength="60"  pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}" oninvalid="setCustomValidity('格式错误')"  oninput="setCustomValidity('')">
            </div>

            <div class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <input type="radio" name="sex" value="男" title="男" checked>
                        <input type="radio" name="sex" value="女" title="女" >
                    </div>
                </div>
            </div>


            <div class="form_item">
                <input type="submit" id="zc" value="注册" >
            </div>
        </form>
        <div class="info">已有账号？点击<a href="/bbs/login"><span class="switch login_Btn">登录</span></a></div>
    </div>

</div>



</body>
</html>