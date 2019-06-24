
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>帖子列表</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="/statics/layui/css/layui.css">
  <link rel="stylesheet" href="/statics/css/global.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div style="height:300px;width:200px">
    <img src="/statics/images/ban1.jpg"  alt="banner" />
</div>
<br>


<div  align="center">
    <span style=" color:#1E9FFF ;font-size:20px">欢迎光临${board.boardname}版块！</span>
  <c:if test="${not empty uid}">
  <a  href="/bbs/post/addPost?bid=${board.boardid}" class="layui-btn">发表新帖</a>

    <c:if test="${empty board.boardadmin}">
    <a  class="layui-btn"  onclick="shenqing()">申请版主</a><br>
    </c:if>
  </c:if>
</div>
<br>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel">
        <div class="fly-panel-title fly-filter">
          <a>置顶</a>
        </div>



        <ul class="fly-list">
          <c:if test="${not empty notice}" var="flag1">
          <c:forEach items="${notice}" var="notice1">
          <li>
            <a href="/bbs/user/home?id=${notice1.user.id}" class="fly-avatar">
              <img src="/statics/images/avatar/${notice1.user.head}" alt="${notice1.user.username}">
            </a>
            <h2>

                <a class="layui-badge">公告</a>
              <a href="/bbs/post/notice/${notice1.pid}?bid=${board.boardid}">${notice1.title}</a>
            </h2>
            <div class="fly-list-info">
              <a href="/bbs/user/home?id=${notice1.user.id}" link>
                <cite>${notice1.user.username}</cite>
                <i class="layui-badge fly-badge-vip layui-hide-xs">论坛管理员</i>
              </a>
              <span><fmt:formatDate value="${notice1.addtime}" pattern="yyyy-MM-dd HH:mm"/></span>



            </div>
          </li>
          </c:forEach>
          </c:if>
            <c:if test="${not empty top}" var="flag2">
            <c:forEach items="${top}" var="top1">
              <li>
                <a href="/bbs/user/home?id=${top1.user.id}" class="fly-avatar">
                  <img src="/statics/images/avatar/${top1.user.head}" alt="${top1.user.username}">
                </a>
                <h2>

                  <a class="layui-badge">置顶</a>
                  <a href="/bbs/post/${top1.pid}">${top1.title}</a>
                </h2>
                <div class="fly-list-info">
                  <a href="/bbs/user/home?id=${top1.user.id}" link>
                    <cite>${top1.user.username}</cite>
                    <c:if test="${top1.user.roleflag==7}" >
                    <i class="layui-badge fly-badge-vip layui-hide-xs">论坛管理员</i></c:if>
                    <c:if test="${not empty aid&&aid==top1.user.id}" >
                      <i class="layui-badge fly-badge-vip layui-hide-xs">本版版主</i></c:if>
                  </a>
                  <span><fmt:formatDate value="${top1.addtime}" pattern="yyyy-MM-dd HH:mm"/></span>

                  <span class="fly-list-nums">
                <i class="iconfont icon-pinglun1" title="回复"></i> ${top1.replies}
                 <i class="iconfont" title="人气">&#xe60b;</i> ${top1.views}
              </span>
                </div>
              </li>
            </c:forEach>
            </c:if>
          <c:if test="${not flag1&&not flag2}">
            <div class="fly-none">暂无帖子</div>
          </c:if>


        </ul>
      </div>





      <div class="fly-panel" style="margin-bottom: 0;">
        
        <div class="fly-panel-title fly-filter">
          <a href="?paixu=new1" <c:if test="${paixu eq 'new1'}"> class="layui-this"</c:if>  >最新发布</a>
          <span class="fly-mid"></span>
          <a href="?paixu=good" <c:if test="${paixu eq 'good'}"> class="layui-this"</c:if> >精华</a>
            <span class="fly-mid"></span>
            <a href="?paixu=nre"  <c:if test="${paixu eq 'nre'}"> class="layui-this"</c:if>  >最新回复</a>
        </div>


        <ul class="fly-list" id="page">
          <c:if test="${not empty postlist}" var="flag">
          <c:forEach items="${postlist}" var="post">
          <li>
            <a href="/bbs/user/home?id=${post.user.id}" class="fly-avatar">
              <img src="/statics/images/avatar/${post.user.head}" alt="${post.user.username}">
            </a>
            <h2>
              <a href="/bbs/post/${post.pid}">   ${post.title}</a>
            </h2>
            <div class="fly-list-info">
              <a href="/bbs/user/home?id=${post.user.id}" link>
                <cite>${post.user.username}</cite>
                <c:if test="${post.user.roleflag==7}" >
                  <i class="layui-badge fly-badge-vip layui-hide-xs">论坛管理员</i></c:if>
                <c:if test="${not empty aid&&aid==post.user.id}" >
                  <i class="layui-badge fly-badge-vip layui-hide-xs">本版版主</i></c:if>
              </a>
              <span><fmt:formatDate value="${post.addtime}" pattern="yyyy-MM-dd HH:mm"/></span>

              <span class="fly-list-nums">
                         <c:if test="${not empty admin}">
                    <span class="layui-btn layui-btn-xs jie-admin" onclick="del(${post.pid})" type="">删除帖子</span>
                         </c:if>
                   <c:if test="${not empty uid&&uid!=post.user.id}">
                  <span class="layui-btn layui-btn-xs jie-admin" onclick="jubao(${post.pid})" type="">举报帖子</span>
                      </c:if>

                <i class="iconfont icon-pinglun1" title="回复"></i> ${post.replies}
                 <i class="iconfont" title="人气">&#xe60b;</i> ${post.views}
              </span>
            </div>
            <div class="fly-list-badge">
            <c:if test="${post.top==1}">
            <span class="layui-badge layui-bg-black">置顶</span></c:if>
              <c:if test="${post.good==1}">
            <span class="layui-badge layui-bg-red">精帖</span></c:if>

          </div>
          </li>
          </c:forEach>
          </c:if>
          <c:if test="${not flag}">
            <div class="fly-none">暂无帖子</div>
          </c:if>

        </ul>

          <div id="test1"> </div>





      </div>
    </div>
    <div class="layui-col-md4">
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">本版热议</dt>
        <c:if test="${not empty hotp}" var="flag3">
          <c:forEach items="${hotp}" var="post">
        <dd>
          <a href="/bbs/post/${post.pid}">${post.title}</a>
          <span><i class="iconfont icon-pinglun1" title="回复"></i>${post.replies}
            <i class="iconfont" title="">&#xe60b;</i> ${post.views}
          </span>
        </dd>

          </c:forEach>
        </c:if>
        <c:if test="${not flag3}" >
        <div class="fly-none">暂无帖子</div>
        </c:if>
      </dl>

      <!--
        <div id="lay" class="layer-photos-demo">
            <img  height="300" width="600" layer-pid="图片id，可以不写" layer-src="/statics/images/ban1.jpg" src="/statics/images/ban1.jpg" alt="">
            <img  height="300" width="600"  layer-pid="图片id，可以不写" layer-src="/statics/images/banner.png" src="/statics/images/banner.png" alt=""><br>
        </div><br>

        <div id="lay" class="layer-photos-demo">
            <img  height="300" width="600"  layer-pid="图片id，可以不写" layer-src="/statics/images/ban1.jpg" src="/statics/images/ban1.jpg" alt="">
            <img  height="300" width="600"  layer-pid="图片id，可以不写" layer-src="/statics/images/banner.png" src="/statics/images/banner.png" alt="">
        </div>
       -->

    </div>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>
    layui.use('laypage', function() {
        var laypage = layui.laypage;

        //执行一个laypage实例
        laypage.render({
            elem: 'test1' //注意，这里的 test1 是 ID，不用加 # 号
            ,count: ${count}//数据总数，从服务端得到
        ,limit:10,
            curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
                var page = location.search.match(/page=(\d+)/);
                return page ? page[1] : 1;
            }(),
            jump: function(e, first){ //触发分页后的回调
                if(!first){ //一定要加此判断，否则初始时会无限刷新
                    location.href = '?page='+e.curr+'&&paixu=${paixu}'+'#posts';

                }
            }

        });});


    layui.use('layer');
    var layer=layui.layer;



    function del(id){
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
        });}

    function jubao(id){
        layer.prompt({
            formType: 2,
            value: '',
            title: '请输入理由',
            maxlength: 130,
            area: ['400px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            layer.close(index);
            $.post("/bbs/user/reportp",{reason:value,pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    layer.alert("举报成功！");
                }else{
                    layer.alert("举报失败，请重试");
                }})
        });
          }

   /* function a(){
        layui.use('layer', function() {
            var layer = layui.layer;

            layer.open({
                type: 2,
                area: ['600px', '500px'],
                content: '/bbs/jinyan' ,
                btn: ['确认', '取消'],
               yes: function(index, layero){
                    var name = layer.getChildFrame('#name', index);
                   console.log(name.val());
                   var uid = layer.getChildFrame('#uid', index);
                   console.log(uid.val());
                   layer.closeAll();
                }
            });
        })}*/




    function shenqing(){
        layer.prompt({
            formType: 2,
            value: '',
            title: '请输入理由',
            maxlength: 130,
            area: ['400px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            layer.close(index);
            $.post("/bbs/user/shenqingbanzhu",{reason:value,bid:${board.boardid}},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    layer.alert("申请成功！");
                }else{
                    layer.alert("申请失败，请重试");
                }})

        });}

</script>
</body>
</html>