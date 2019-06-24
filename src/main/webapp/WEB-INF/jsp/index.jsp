
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <title>版块列表</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="/statics/layui/css/layui.css">
  <link rel="stylesheet" href="/statics/css/global.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!--
    </ul>
  </div>
</div>

<div class="fly-panel fly-column">
  <div class="layui-container">


    <div class="fly-column-right layui-hide-xs"> <!--搜索 -->

      <!--<a href="../../statics/html/jie/add.html" class="layui-btn">发表新帖</a>
    </div> 

  </div>
</div>-->


<div style="height:465px;width:200px">
<img src="/statics/images/banner.png"  alt="banner" />
</div>
<br>

<!--
<div  align="center">
<a href="../../statics/html/jie/add.html" class="layui-btn">发表新帖</a>
<a href="../../statics/html/jie/add.html" class="layui-btn">发表回复</a></div><br>-->

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a href="#" class="layui-this">版块</a>
          <span class="fly-mid"></span>

        </div>

        <c:if test="${not empty boardlist}" var="flag1">
        <ul class="fly-list">
          <c:forEach items="${boardlist}" var="board">
          <li>


            <a href="/bbs/board/${board.boardid}" class="fly-avatar">
              <img  src="/statics/images/forum_new.gif" >
            </a>
            <h2>
              <a href="/bbs/board/${board.boardid}">${board.boardname}</a>
            </h2>
            <div class="fly-list-info">
              <c:if test="${board.boardadmin==NULL}" var="flag">
                  <cite>暂无版主</cite>
                </c:if>
                <c:if test="${not flag}">
              <a href="/bbs/user/home?id=${board.boardadmin.id}" link>
                <cite>版主：${board.boardadmin.username}</cite>
                </c:if>
              </a>

              <span class="fly-list-nums"> 
                <i class="iconfont icon-pinglun1" title="帖子数"></i> ${board.postnum}
              </span>
            </div>
          </li>
          </c:forEach>
        </ul>
        </c:if>
        <c:if test="${not flag1}">
         <div class="fly-none">没有相关数据</div>
        </c:if>

        <!--<div style="text-align: center">
          <div class="laypage-main"><span class="laypage-curr">1</span><a href="/jie/page/2/">2</a><a href="/jie/page/3/">3</a><a href="/jie/page/4/">4</a><a href="/jie/page/5/">5</a><span>…</span><a href="/jie/page/148/" class="laypage-last" title="尾页">尾页</a><a href="/jie/page/2/" class="laypage-next">下一页</a></div>
        </div>-->

      </div>
    </div>
    <div class="layui-col-md4">
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">今日热议</dt>
        <c:if test="${not empty postlist}" var="flag2">
          <c:forEach items="${postlist}" var="post">
        <dd>
          <a href="/bbs/post/${post.pid}">${post.title}</a>
          <span><i class="iconfont icon-pinglun1"></i> ${post.replies}
          <i class="iconfont" >&#xe60b;</i>${post.views}</span>
        </dd>
          </c:forEach>
        </c:if>
        <c:if test="${not flag2}" >
        <div class="fly-none">暂无帖子</div>
        </c:if>
      </dl>
    </div>
  </div>
</div>



<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>

</script>

</body>
</html>