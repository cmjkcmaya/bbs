<!DOCTYPE html>
<html>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<head>
<meta charset="utf-8" />
<title>登录</title>

<link rel="stylesheet" type="text/css" href="/statics/css/index.css" />
</head>

<body>

<img class="bgone" src="/statics/images/1.jpg" />
<img class="pic" src="/statics/images/a.png" />

<div class="table">
	<div class="wel">论坛管理后台登录</div>
	<div class="wel1">bbs manage system</div>
	<div class="wel1" align="center" style="color:#F00">${error}</div>

	<form action="login" method="post">

		<div>
	<div class="user">


		<div id="yonghu" style=""><img src="/statics/images/yhm.png" /></div>
			<input type="text" name="username" required   maxlength="30" placeholder="请输入用户名" />
	</div>
	<div class="password">
		<div id="yonghu1"><img src="/statics/images/mm.png" /></div>
		<input type="password"  name="password" required   maxlength="30" placeholder="请输入密码"/>
	</div>

	<input class="btn" type="submit"  value="登录" />

		</div>
	</form>
</div>

</body>
</html>