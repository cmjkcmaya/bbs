<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>等级权限</title>
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
    <li class="layui-nav-item ">
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
    <li class="layui-nav-item">
      <a href="/bbs/user/message">
        <i class="layui-icon">&#xe611;</i>
        我的消息<font color="red">(<%=i%>)</font>
      </a>
    </li>
    <li class="layui-nav-item layui-this">
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

    <div class="layui-tab layui-tab-brief" lay-filter="user">

      <br><br>
      <span>您当前的等级为：LV<fmt:formatNumber type="number" value="${lv}" maxFractionDigits="0"/>  经验值为${user.exp}  距离下一等级差<fmt:formatNumber type="number" value="${lv>=5?0:lv*100-user.exp}" maxFractionDigits="0"/>经验</span>
    <br><br><br>
      <table class="layui-table">

        <thead>
        <tr>
          <th>权限</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${permission}" var="p">
        <tr>
          <td>${p.detail}</td>
        </tr>
        </c:forEach>
        </tbody>
      </table>


    </div>
  </div>
</div>


<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>
    layui.use('table');

</script>

</body>
</html>