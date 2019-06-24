<%@ page import="com.wzn.bysj.bbs.util.UserUtil" %>
<%@ page import="com.wzn.bysj.bbs.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>Title</title>
</head>
<body >
<link rel="stylesheet" href="/statics/layui/css/layui.css">
<link rel="stylesheet" href="/statics/css/global.css">
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" href="#">
            <img src="/statics/images/logo.png" alt="layui"  width=160px height=45px >
        </a>
        <ul class="layui-nav fly-nav layui-hide-xs">
            <li class="layui-nav-item ">
                <a href="/bbs/index"><i class="iconfont icon-jiaoliu"></i>首页</a>
            </li>
            <li class="layui-nav-item ">
                <a href="/bbs/searchp"><i class="iconfont icon-jiaoliu"></i>查找帖子</a>
            </li>
<shiro:hasPermission name="User">
            <li class="layui-nav-item ">
                <a href="/bbs/searchu"><i class="iconfont icon-jiaoliu"></i>查找用户</a>
            </li>
</shiro:hasPermission>
        </ul>

        <ul class="layui-nav fly-nav-user">

            <%

                int i=0;
                i=UserUtil.Advisenum();
                User u;
                if((u=UserUtil.getU())==null){%>
            <!-- 未登入的状态 -->
            <li class="layui-nav-item">
                <a class="iconfont icon-touxiang layui-hide-xs" href="/bbs/login"></a>
            </li>
            <li class="layui-nav-item">
                <a href="/bbs/login">登入</a>
            </li>
            <li class="layui-nav-item">
                <a href="/bbs/register">注册</a>
            </li>
<%  }else{ %>
            <!-- 登入后的状态 -->

            <li class="layui-nav-item">
              <a class="fly-nav-avatar" href="/bbs/user/home">
                <cite class="layui-hide-xs"><%=u.getUsername()%></cite>
                  <% boolean log=UserUtil.dailylogin();
                      String shenfen="0";
                      if(u.getRoleflag()==6) {shenfen="版主";}
                  if(u.getRoleflag()==7){shenfen="管理员";}
                  if(!shenfen.equals("0")){
                  %>
                <i  class="layui-badge fly-badge-vip layui-hide-xs"><%=shenfen%></i><%}%>
                  <img   src="/statics/images/avatar/<%=u.getHead()%>"/>
              </a>
              <dl class="layui-nav-child">
                <dd><a href="/bbs/user/set"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
                <dd><a href="/bbs/user/message"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息 <font color="red">(<%=i%>)</font></a></dd>
                <dd><a href="/bbs/user/post"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的帖子</a></dd>
                <hr style="margin: 5px 0;">
                <dd><a href="/bbs/logout" style="text-align: center;">退出</a></dd>
              </dl>
            </li>
            <%  } %>
        </ul>
    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">


        <div class="fly-column-right layui-hide-xs"> <!--搜索 -->

            <!--<a href="../../statics/html/jie/add.html" class="layui-btn">发表新帖</a>       -->
        </div>

    </div>
</div>
<script type="text/javascript" src="/statics/js/jquery.js"></script>
<script src="/statics/layui/layui.js"></script>
<script>

    layui.use('element', function(){
        var element = layui.element;

    });
   function on(){
       layui.use('layer',function () {
           var layer=layui.layer;
           layer.msg("每日登录 经验+2 积分+10")
       });

   }


</script>
</body>
</html>
