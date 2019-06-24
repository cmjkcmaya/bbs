<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <title>用户查找</title>
    <link rel="stylesheet" href="/statics/layui/css/layui.css">
    <link rel="stylesheet" href="/statics/css/global.css">
    <link rel="stylesheet" href="/statics/css/search.css">
</head>

<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div class="wrapper">
    <div class="search" >
        <input id="search"  type="text" class="inp" value="${search}" placeholder="请输入用户名" maxlength="30">
        <div align="center">
            <a  class="layui-btn"  onclick="search1()">搜索用户</a><br>
        </div>
    </div>
    <c:if test="${empty result}" var="flag">
        <div class="fly-none">没有相关数据</div>
    </c:if>
    <c:if test="${not flag}">
    <ul class="user">
<c:forEach items="${result}"  var="user">
        <li onclick="location.href='/bbs/user/home?id=${user.id}'">
        <div class="head-img">
            <img src='/statics/images/avatar/${user.head}' alt="${user.username}">
        </div>
        <div class="tit">
            <h1  class="name">${user.username}</h1>
            <p class="motto">${user.msg}</p>
        </div>
    </li>
        </c:forEach>
    </ul>

    </c:if>
    <div id="test1"> </div>
</div>



<%@ include file="/WEB-INF/jsp/footer.jsp"%>

<script>
    layui.use(['layer', 'form'], function () {
        var layer = layui.layer
            , form = layui.form;
    });

    layui.use('laypage', function() {
        var laypage = layui.laypage;

        //执行一个laypage实例
        laypage.render({
            elem: 'test1' //注意，这里的 test1 是 ID，不用加 # 号
            ,count: ${count}  //数据总数，从服务端得到
            ,limit:7,
            curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
                var page = location.search.match(/page=(\d+)/);
                return page ? page[1] : 1;
            }(),
            jump: function(e, first){ //触发分页后的回调
                if(!first){ //一定要加此判断，否则初始时会无限刷新
                    location.href = '?page='+e.curr+'&&search=${search}';

                }
            }

        });});
function search1() {
    location.href='?search='+$("#search").val();
}
</script>

</body>
</html>
