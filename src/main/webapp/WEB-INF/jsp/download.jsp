<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
    <title>文件下载</title>
</head>
<link rel="stylesheet" href="/statics/layui/css/layui.css">
<link rel="stylesheet" href="/statics/css/global.css">
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<div align="center">
    <h1>${file}文件下载</h1>
    <br>
    <h3>注意 点击下载后积分就会扣除，请确定要下载再点击</h3>
    <br>
    <span class="layui-inline layui-upload-choose" >文件类型：${fn:split(file,'.')[1]}</span>
    <span class="layui-inline layui-upload-choose" >上传者：${post.user.username}</span>
    <span class="layui-inline layui-upload-choose" >
        <c:if test="${not empty post.board}">
            <a href="/bbs/post/${post.pid}">来源：${post.title}</a>
        </c:if>
    <c:if test="${empty post.board}">
        <a href="/bbs/post/notice/${post.pid}">来源：${post.title}</a>
    </c:if>
    </span>


    <span class="layui-inline layui-upload-choose" >所需积分：${post.scores}</span>
 <br>
    <br>
<shiro:hasPermission name="File">
    <button id="sub" class="layui-btn" onclick="dl()" lay-filter="*" lay-submit>下载</button>
</shiro:hasPermission>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</body>

<script type="text/javascript" src="/statics/js/jquery.js"></script>
<script src="/statics/layui/layui.js"></script>
<script>
    function dl(){
    $.post("/bbs/post/scores",{scores:${post.scores}},function (msg) {
        console.log(msg);
        if(msg=="false"){
            layui.use('layer', function () {
                var layer = layui.layer;
                layer.msg("积分不足 无法下载");
            })
        }else{
            self.location="/bbs/post/fileDownLoad?file=${file}&&scores=${post.scores}&&uid=${post.user.id}";
        }
    });}




</script>
</html>
