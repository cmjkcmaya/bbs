<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/statics/layui/css/layui.css">
</head>
<body>


<script src="/statics/layui/layui.js"></script>
<script>

    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
    });
</script>
<br>
<div align="center">
<form class="layui-form" action="">
    <!--<input type="hidden" id="name" value="11">-->
    <div class="layui-input-block" style="height:300px;width:200px">
        <select id="user"   lay-verify="required" lay-search>
                <option value=""></option>
          <c:forEach items="${users}" var="user">
    <option value="${user.id}">${user.username}</option>
                </c:forEach>

            </select>
    </div>

</form>
</div>


</body>
</html>
