<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>发帖记录</title>
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
    <li class="layui-nav-item layui-this">
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

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user" pad20>

    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我发的帖（<span>${count}</span>）</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <c:if test="${not empty post}">

          <ul class="mine-view jie-row">
            <c:forEach items="${post}" var="p">
            <li>
              <a class="jie-title" href="/bbs/post/${p.pid}" target="_blank">${p.title}</a>
              <i><fmt:formatDate value="${p.addtime}" pattern="yyyy-MM-dd HH:mm"/></i>
              <a class="mine-edit" href="/bbs/post/editpost?pid=${p.pid}"  target="_blank">编辑</a>
              <a class="mine-edit"  href="javascript:void(0);" onclick="del(${p.pid})">删除</a>
              <em>${p.views}阅/${p.replies}回复</em>
            </li></c:forEach>
          </ul>
          <div id="page"></div></c:if>
          <c:if test="${empty post}">
          <div class="fly-none">暂无帖子</div>
        </c:if>
        </div>

      </div>
    </div>
  </div>
</div>


<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>
    layui.use('laypage', function() {
        var laypage = layui.laypage;

        //执行一个laypage实例
        laypage.render({
            elem: 'page' //注意，这里的是 ID，不用加 # 号
            ,count: ${count}//数据总数，从服务端得到
            ,limit:10,
            curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
                var page = location.search.match(/page=(\d+)/);
                return page ? page[1] : 1;
            }(),
            jump: function(e, first){ //触发分页后的回调
                if(!first){ //一定要加此判断，否则初始时会无限刷新
                    location.href = '?page='+e.curr;

                }
            }

        });});
    layui.use('layer');
    var layer = layui.layer;

    function  del(id) {
        layer.confirm('确定要删除该帖子么', function(index){
            layer.close(index);
            $.post("/bbs/post/delp",{pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });
    }


</script>

</body>
</html>