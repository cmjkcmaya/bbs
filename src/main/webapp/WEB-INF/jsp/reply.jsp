


<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>帖子内容</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="/statics/layui/css/layui.css">
  <link rel="stylesheet" href="/statics/css/global.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div style="height:300px;width:200px">
  <img src="/statics/images/ban2.jpg"  alt="banner" />
</div>
<br>

<div  align="center">
<c:if test="${not empty board}">
  <a href="/bbs/board/${board.boardid}"  class="layui-btn">返回列表</a>
  <c:if test="${not empty uid}">
  <a href="/bbs/post/addPost?bid=${board.boardid}" class="layui-btn">发表新帖</a>
      <c:if test="${empty notice}">
    <a  href="/bbs/post/addRe?pid=${post.pid}" class="layui-btn">发表回复</a><br></c:if>
  </c:if>
  </c:if>
</div>
<br>


<c:set var="i" value="1"></c:set>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${post.title}</h1>
        <div class="fly-detail-info">
       <c:if test="${post.board.boardid==0}">
          <span class="layui-badge layui-bg-green fly-detail-column">公告</span></c:if>
          <c:if test="${post.top==1}">
            <span class="layui-badge layui-bg-black">置顶</span></c:if>
          <c:if test="${post.good==1}">
            <span class="layui-badge layui-bg-red">精帖</span></c:if>
          
          <div class="fly-admin-box" data-id="123">
              <c:if test="${not empty uid&&post.board.boardid!=0&&uid!=post.user.id}">
                  <span  style="font-size:12px"  class="layui-btn layui-btn-xs jie-admin" type="del"  onclick="jubao(${post.pid})">举报帖子</span>
              </c:if>
            <c:if test="${not empty admin&&post.board.boardid!=0}">
            <c:if test="${uid!=post.user.id}">
            <span class="layui-btn layui-btn-xs jie-admin"  onclick="del(${post.pid})" type="del">删除帖子</span>
              <span class="layui-btn layui-btn-xs jie-admin"  onclick="location.href='/bbs/post/editpost?pid=${post.pid}'"  type="del">编辑帖子</span>
            </c:if>
              <c:if test="${post.top!=1}">
                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1" onclick="settop(${post.pid})">置顶该帖</span></c:if>
              <c:if test="${post.top==1}">
                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;" onclick="canceltop(${post.pid})">取消置顶</span></c:if>
              <c:if test="${post.good!=1}">
                <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1" onclick="setgood(${post.pid})">加精</span> </c:if>
              <c:if test="${post.good==1}">
             <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;"  onclick="cancelgood(${post.pid})">取消加精</span>
              </c:if>
            </c:if>

          </div>

          <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回复">&#xe60c;</i> ${post.replies}</a>
            <i class="iconfont" title="人气">&#xe60b;</i> ${post.views}
          </span>
        </div>
        <div class="detail-about">
          <a class="fly-avatar" href="/bbs/user/home?id=${main.user.id}">
            <img src="/statics/images/avatar/${main.user.head}" alt="${main.user.username}">
          </a>
          <div class="fly-detail-user">
            <a href="/bbs/user/home?id=${main.user.id}" class="fly-link">
              <cite>${main.user.username}</cite>
              <c:if test="${main.user.roleflag==7}" >
                <i class="layui-badge fly-badge-vip layui-hide-xs">论坛管理员</i></c:if>
              <c:if test="${not empty board.boardadmin&&board.boardadmin.id==main.user.id}" >
                <i class="layui-badge fly-badge-vip layui-hide-xs">本版版主</i></c:if>
            </a>
            <span><fmt:formatDate value="${post.addtime}" pattern="yyyy-MM-dd HH:mm"/></span>
          </div>
          <div class="detail-hits" id="LAY_jieAdmin" data-id="123">
          <c:if test="${main.user.id==uid}">

            <span class="layui-btn layui-btn-xs jie-admin" type="edit"  onclick="location.href='/bbs/post/editpost?pid=${post.pid}'"  >编辑此贴</span>
                  <c:if test="${post.board.boardid!=0}">
            <span class="layui-btn layui-btn-xs jie-admin" type="edit" onclick="del(${post.pid})">删除此贴</span></c:if>
              <c:if test="${post.board.boardid!=0&&post.good!=1}">
              <span class="layui-btn layui-btn-xs jie-admin" type="edit" onclick="shenqing(${post.pid})">申请加精</span></c:if>
          </c:if>
            <br>
          </div>
        </div><br>
        <div class="detail-body photos">

          <p>
          ${main.content}
          </p>



          <c:if test="${not empty main.images}">
              <br>
          附图<hr>
              <div id="lay${i}" class="layer-photos-demo">
<c:forEach items="${fn:split(main.images,',')}" var="img">


                  <img   width="600"  layer-src="/statics/files/${img}" src="/statics/files/${img}" alt=""><br>

              </c:forEach>
          <br> </div><c:set var="i" value="${i+1}"></c:set><br>
          </c:if>

          <c:if test="${not empty post.files}">
              <shiro:hasPermission name="File">
              <br>
            附件下载（每个需${post.scores}积分）<hr>
            <p>
                <c:forEach items="${fn:split(post.files,',')}" var="file">
                    <a href="/bbs/post/dl?pid=${post.pid}&&file=${file}" >${file}</a><br>
                </c:forEach>
            </p>
            <br>
          </shiro:hasPermission>
          </c:if>


        </div>
      </div>



      <div class="fly-panel detail-box" id="flyReply">
          <c:if test="${empty notice}">
              <a name="reply"></a>
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>回帖</legend>
        </fieldset>

        <ul class="jieda" id="jieda">




          <c:if test="${not empty reply}" var="flag">

         <c:forEach items="${reply}" var ="re">
          <li data-id="111" class="jieda-daan">
            <a name="item-1111111111"></a>
            <div class="detail-about detail-about-reply">
              <a class="fly-avatar" href="/bbs/user/home?id=${re.user.id}">
                <img src="/statics/images/avatar/${re.user.head}" alt=" ${re.user.username}">
              </a>
              <div class="fly-detail-user">
                <a href="/bbs/user/home?id=${re.user.id}" class="fly-link">
                  <cite>${re.user.username}</cite>
                  <c:if test="${re.user.roleflag==7}" >
                    <i class="layui-badge fly-badge-vip layui-hide-xs">论坛管理员</i></c:if>
                  <c:if test="${not empty board.boardadmin&&board.boardadmin.id==re.user.id}" >
                    <i class="layui-badge fly-badge-vip layui-hide-xs">本版版主</i></c:if>
                </a>
                <c:if test="${main.user.id==re.user.id}">
                <span>(楼主)</span></c:if>
              </div>

              <div class="detail-hits">
                <span><fmt:formatDate value="${re.replytime}" pattern="yyyy-MM-dd HH:mm"/></span>
              </div>

            </div><br>
            <div class="detail-body jieda-body photos">
              <p>${re.content}</p>
              <!--<pre>
            回复 3楼</pre>-->
            </div>
              <c:if test="${not empty re.images}">
                  <br>
                  附图<hr>
                  <div id="lay${i}" class="layer-photos-demo">
                      <c:forEach items="${fn:split(re.images,',')}" var="img">


                          <img   width="600"  layer-src="/statics/files/${img}" src="/statics/files/${img}" alt=""><br>

                      </c:forEach>
                      <br> </div><c:set var="i" value="${i+1}"></c:set><br>
              </c:if>

            <div class="jieda-reply">

              <span type="reply"><c:if test="${uid!=re.user.id}">
                <i class="iconfont icon-svgmoban53"></i>
                <a href="/bbs/post/addRere?rid=${re.rid}"> 回复</a></c:if>
              </span>
              <div class="jieda-admin">
                <span>${re.floor}楼</span>
                <c:if test="${not empty admin||re.user.id==uid}">
                  <span type="edit" onclick="self.location='/bbs/post/editre?rid=${re.rid}'">编辑</span></c:if>
                <c:if test="${not empty admin||main.user.id==uid||re.user.id==uid}">
                <span type="del" onclick="delr(${re.rid})">删除</span></c:if>
                <!-- <span class="jieda-accept" type="accept">采纳</span> -->
              </div>
            </div>
          </li>
         </c:forEach>
          </c:if>
          <c:if test="${not flag}">
           <li class="fly-none">暂无回复，快来抢沙发</li>

          </c:if>

            <div id="test1"> </div>
        </ul>
        <c:if test="${forbid!=1}">
        <div class="layui-form layui-form-pane">
          <form action="/bbs/post/addRe" method="post">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <textarea id="L_content" name="content" required lay-verify="required" placeholder="请输入内容 不超过850字"   maxlength="850" class="layui-textarea fly-editor" style="height: 150px;"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="hidden" name="pid" value="${post.pid}">
              <button class="layui-btn" lay-filter="*" lay-submit>快速回复</button>
            </div>

          </form>
        </div>
        </c:if>
          </c:if>
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

    </div>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>

    layui.use('layer');
    var layer=layui.layer;


    function delr(id){
        layer.confirm('确定要删除该回复么', function(index){
            layer.close(index);
            $.post("/bbs/post/delr",{rid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });}


    function del(id){
        layer.confirm('确定要删除该帖子么', function(index){
            layer.close(index);
            $.post("/bbs/post/delp",{pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    self.location="/bbs/board/${board.boardid}";
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });}

    function settop(id){
        layer.confirm('确定要置顶该帖子么', function(index){
            layer.close(index);
            $.post("/bbs/user/settop",{pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                   location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });}
    function canceltop(id){
        layer.confirm('确定要取消置顶么', function(index){
            layer.close(index);
            $.post("/bbs/user/canceltop",{pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });}
    function setgood(id){
        layer.confirm('确定要加精吗', function(index){
            layer.close(index);
            $.post("/bbs/user/tongguo",{pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });}
    function cancelgood(id){
        layer.confirm('确定取消加精吗', function(index){
            layer.close(index);
            $.post("/bbs/user/cancelgood",{pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });}



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
                    location.href = '?page='+e.curr+'#reply';

                }
            }

        });});


    <c:forEach var="a" begin="1" end="${i}" step="1">
    layui.use('layer',function() {
        var layer=layui.layer;

        layer.photos({
            photos: '#lay${a}'
            , anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机
        });
    });
    </c:forEach>

    function shenqing(id){
        layer.prompt({
            formType: 2,
            value: '',
            title: '请输入理由',
            maxlength: 130,
            area: ['400px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            layer.close(index);
            $.post("/bbs/user/shenqinggood",{reason:value,pid:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    layer.alert("申请成功！");
                }else{
                    layer.alert("申请失败，请重试");
                }})

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

</script>

</body>
</html>