<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>我的消息</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="/statics/layui/css/layui.css">
  <link rel="stylesheet" href="/statics/css/global.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>


<div class="layui-container fly-marginTop fly-user-main">
  <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
    <li class="layui-nav-item">
      <a href="/bbs/user/home">
        <i class="layui-icon">&#xe609;</i>
        我的主页
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="/bbs/user/post">
        <i class="layui-icon">&#xe612;</i>
        发帖记录
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="/bbs/user/set">
        <i class="layui-icon">&#xe620;</i>
        基本设置
      </a>
    </li>
    <li class="layui-nav-item layui-this">
      <a href="/bbs/user/message">
        <i class="layui-icon">&#xe611;</i>
        我的消息 <font color="red">(<%=i%>)</font>
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="/bbs/user/level">
        <i class="layui-icon">&#xe611;</i>
        我的等级权限
      </a>
    </li>

    <c:if test="${user.roleflag==6||user.roleflag==7}">

    <li class="layui-nav-item">
      <a href="/bbs/user/jubao">
        <i class="layui-icon">&#xe611;</i>
        举报处理
      </a>
    </li>
    <li class="layui-nav-item">
      <a href="/bbs/user/jinyan">
        <i class="layui-icon">&#xe611;</i>
        我禁言的用户
      </a>
    </li>
      <li class="layui-nav-item">
      <a href="/bbs/user/good">
        <i class="layui-icon">&#xe611;</i>
        精品帖申请处理
      </a>
    </li>
      </c:if>

  </ul>




  <div class="fly-panel fly-panel-user" pad20>
	  <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
        <c:if test="${not empty advise}" >
	    <button class="layui-btn layui-btn-danger" onclick="delall()" id="LAY_delallmsg">清空全部消息</button></c:if>
	    <div  id="LAY_minemsg" style="margin-top: 10px;">
          <c:if test="${empty advise}" var="flag">
        <div class="fly-none">您暂时没有消息</div></c:if>
          <c:if test="${not flag}">
        <ul class="mine-msg">
          <c:forEach items="${advise}" var="msg">
          <li>
            <blockquote class="layui-elem-quote">
              <a href="/bbs/user/home?id=${msg.poster.id}" target="_blank"><cite>${msg.poster.username}</cite></a>${msg.content}
            </blockquote>
            <p><span><fmt:formatDate value="${msg.ptime}" pattern="yyyy-MM-dd HH:mm"/></span>
              <c:if test="${msg.recer.id!=0&&msg.recer.id!=-1}" var="flag1">
                <a href="javascript:;"  onclick="del(${msg.aid})" class="layui-btn layui-btn-small layui-btn-danger fly-delete"  >删除</a>
              </c:if>
              <c:if test="${not flag1}">
              <a href="javascript:;" class="layui-btn layui-btn-small layui-btn-danger fly-delete layui-btn-disabled" >删除</a>
              </c:if></p>
          </li>
          </c:forEach>

        </ul>
          </c:if>
      </div>
	  </div>
	</div>

</div>


<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>

    layui.use('layer');
    function del(id){

            var layer = layui.layer;
            layer.confirm('确定删除吗?', {icon: 3, title: '提示'}, function (index) {
                layer.close(index);
                $.post("/bbs/user/del",{id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("删除失败，请重试");
                    }
                })

            });
    }
        
        function delall() {
            var layer = layui.layer;
            layer.confirm('确定清空吗?', {icon: 3, title: '提示'}, function (index) {
                layer.close(index);
                $.post("/bbs/user/delall",function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("删除失败，请重试");
                    }
                })

            });
        }

</script>

</body>
</html>