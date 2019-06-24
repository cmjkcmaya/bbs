<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户主页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="/statics/layui/css/layui.css">
  <link rel="stylesheet" href="/statics/css/global.css">
</head>
<body style="margin-top: 65px;">

<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div class="fly-home fly-panel" style="background-image:url('/statics/images/ban5.jpg')">
  <img src="/statics/images/avatar/${u.head}" alt="${u.username}">

  <h1>
    ${u.username}
    <c:if test="${u.sex=='男'}">
    <i class="iconfont icon-nan"></i></c:if>
      <c:if test="${u.sex=='女'}">
        <i class="iconfont icon-nv"></i></c:if>

    <c:if test="${u.roleflag==6}">
    <i class="layui-badge fly-badge-vip">版主</i></c:if>
    <c:if test="${u.roleflag==7}">
      <i class="layui-badge fly-badge-vip">管理员</i></c:if>
<br>
    <c:if test="${u.forbid==1}" var="flag1">
    <span><font color="red"> 该号已被禁言</font></span>
    </c:if>
    <c:if test="${u.block==1}" var="flag2">
    <span><font color="red"> 该号已被封禁</font></span>
    </c:if>
    <!--
    <span style="color:#c00;">（管理员）</span>
    <span style="color:#5FB878;">（社区之光）</span>
    <span>（该号已被封）</span>
    -->
  </h1>



  <p class="fly-home-info">
   <span style="color: #FF7200;">${u.score}积分</span>

    <i class="layui-badge fly-badge-vip">LV<fmt:formatNumber type="number" value="${lv}" maxFractionDigits="0"/> </i>
    <i class="iconfont icon-shijian"></i><span>于<fmt:formatDate value="${u.logintime}" pattern="yyyy-MM-dd HH:mm"/>登录</span>

  </p>

  <p class="fly-home-sign">个性签名:${u.msg}</p>

  <div class="fly-sns" data-user="">

    <c:if test="${uid!=u.id}">
      <shiro:hasPermission name="Advise">
    <a href="javascript:;" class="layui-btn layui-btn-normal fly-imActive" onclick="zhanneixin(${u.id})" data-type="chat">写站内信</a>
      </shiro:hasPermission>
      <c:if test="${u.roleflag!=7}">
      <a href="javascript:;" class="layui-btn layui-btn-danger fly-imActive" onclick="report(${u.id})" data-type="chat">举报</a>
      </c:if>
    <c:if test="${flag1==false&&u.roleflag!=7}">
      <shiro:hasPermission name="Forbid">
    <a href="javascript:;"  onclick="jinyan(${u.id})" class="layui-btn layui-btn-danger fly-imActive" >禁言</a>
      </shiro:hasPermission>
    </c:if>
    <c:if test="${flag1==true}">
      <shiro:hasPermission name="Forbid">
      <a href="javascript:;"  onclick="jiejin(${u.id})"  class="layui-btn layui-btn-normal fly-imActive" >解禁</a>  </shiro:hasPermission>
    </c:if>

    <c:if test="${flag2==false&&u.roleflag!=7}">
      <shiro:hasPermission name="Block">
      <a href="javascript:;"  onclick="fengjin(${u.id})" class="layui-btn layui-btn-danger fly-imActive" >封禁</a>
      </shiro:hasPermission>
    </c:if>
    <c:if test="${flag2==true}">
      <shiro:hasPermission name="Block">
      <a href="javascript:;"  onclick="jiefeng(${u.id})" class="layui-btn layui-btn-normal fly-imActive" >解封</a>
      </shiro:hasPermission>
    </c:if>
      <c:if test="${u.roleflag!=7}">
      <shiro:hasPermission name="Score">
    <a href="javascript:;"      onclick="jiangli(${u.id})"    class="layui-btn layui-btn-normal fly-imActive" data-type="chat">积分奖赏</a>  </shiro:hasPermission>
      </c:if>
    <c:if test="${u.score>0&&u.roleflag!=7}">
      <shiro:hasPermission name="Score">
    <a href="javascript:;"  onclick="kouchu(${u.id})"  class="layui-btn layui-btn-warm fly-imActive" data-type="chat">积分扣除</a>
      </shiro:hasPermission>
    </c:if>
      <c:if test="${u.roleflag!=7}">
      <shiro:hasPermission name="Admin">
      <a href="javascript:;"  onclick="dengji(${u.id})"  class="layui-btn layui-btn-normal fly-imActive" data-type="chat">修改用户等级</a>
    </shiro:hasPermission>

    <c:if test="${lv==5}">
      <shiro:hasPermission name="Admin">
      <a href="javascript:;"   onclick="badmin(${u.id})"  class="layui-btn layui-btn-normal fly-imActive" data-type="chat"> 设为版主</a>
      </shiro:hasPermission>
    </c:if></c:if>


    </c:if>

  </div>

</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md6 fly-home-jie">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${u.username}最近的发帖记录</h3>
        <ul class="jie-row">
          <c:if test="${not empty post}">
            <c:forEach items="${post}" var="p">
          <li>
            <c:if test="${p.good==1}">
            <span class="fly-jing">精</span></c:if>
            <a href="/bbs/post/${p.pid}" target="_blank" class="jie-title"> ${p.title}</a>
            <i><fmt:formatDate value="${p.addtime}" pattern="yyyy-MM-dd HH:mm"/></i>
            <em class="layui-hide-xs">${p.views}阅/${p.replies}回复</em>
          </li>
            </c:forEach>
          </c:if>
          <c:if test="${empty post}">
           <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何帖子</i></div>
          </c:if>
        </ul>
      </div>
    </div>
    
    <div class="layui-col-md6 fly-home-da">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${u.username}的精品帖</h3>
        <ul class="home-jieda">
          <c:if test="${not empty goodpost}">
            <c:forEach items="${goodpost}" var="g">
              <li>
                <a href="/bbs/post/${g.pid}" target="_blank" class="jie-title"> ${g.title}</a>
                <i><fmt:formatDate value="${g.addtime}" pattern="yyyy-MM-dd HH:mm"/></i>
                <em class="layui-hide-xs">${g.views}阅/${g.replies}回复</em>
              </li>
            </c:forEach>
          </c:if>
          <c:if test="${empty goodpost}">
            <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>暂无精品帖</span></div>
          </c:if>
        
          <!-- <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何问题</span></div> -->
        </ul>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>
    layui.use('layer');
    var layer = layui.layer;
    function zhanneixin(id){

            layer.prompt({
                formType: 2,
                value: '',
                title: '请输入内容',
                maxlength: 300,
                area: ['500px', '100px'] //自定义文本域宽高
            }, function(value, index, elem){
                //do something
                layer.close(index);
                $.post("/bbs/user/zhanneixin",{content:value,id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        layer.alert("发送成功！");
                    }else{
                        layer.alert("发送失败，请重试");
                    }})

            });}

    function report(id){

        layer.prompt({
            formType: 2,
            value: '',
            title: '请输入理由',
            maxlength: 120,
            area: ['300px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            //do something
            layer.close(index);
            $.post("/bbs/user/reportu",{reason:value,id:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    layer.alert("举报成功！");
                }else{
                    layer.alert("举报失败，请重试");
                }})

        });}


        function jinyan(id) {
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入天数（1到30天）',
            maxlength: 2

        }, function(value, index, elem){

            value=parseInt(value);
            if(value<=30&&value>=1){
                layer.close(index);
                $.post("/bbs/user/forbidu",{day:value,id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("操作失败，请重试");
                    }})}
            else {
                layer.alert("请输入正确天数");
            }
        });
    }


    function fengjin(id) {
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入天数（1到30天）',
            maxlength: 2

        }, function(value, index, elem){

            value=parseInt(value);
            if(value<=30&&value>=1){
                layer.close(index);
                $.post("/bbs/user/block",{day:value,id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("操作失败，请重试");
                    }})}
            else {
                layer.alert("请输入正确天数");
            }
        });
    }


function jiejin(id) {
    layer.confirm('确定解禁么', function(index){
        layer.close(index);
        $.post("/bbs/user/jiejin",{id:id},function (msg) {
            console.log(msg);
            if(msg=="true"){
                location.reload();
            }else{
                layer.alert("操作失败，请重试");
            }
        })
    });
}

    function jiefeng(id) {
        layer.confirm('确定解封么', function(index){
            layer.close(index);
            $.post("/bbs/user/jiefeng",{id:id},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    location.reload();
                }else{
                    layer.alert("操作失败，请重试");
                }
            })
        });
    }

function jiangli(id) {
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入要给予的分数（1到20分）',
            maxlength: 2
        }, function(value, index, elem){

            value=parseInt(value);
            if(value<=20&&value>=1){
                layer.close(index);
                $.post("/bbs/user/score",{score:value,id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("操作失败，请重试");
                    }})}
            else {
                layer.alert("请输入正确的数字");
            }
        });
}
    function kouchu(id) {
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入要扣除的分数（1到20分）',
            maxlength: 2
        }, function(value, index, elem){

            value=parseInt(value);
            if(value<=20&&value>=1){
                layer.close(index);
                $.post("/bbs/user/score",{score:'-'+value,id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("操作失败，请重试");
                    }})}
            else {
                layer.alert("请输入正确的数字");
            }
        });
    }
    function dengji(id) {
        layer.prompt({
            formType: 0,
            value: '',
            title: '请输入等级（1-5）',
            maxlength: 1
        }, function(value, index, elem){
            value=parseInt(value);
            if(value<=5&&value>=1){
                layer.close(index);
                $.post("/bbs/user/dengji",{lv:value,id:id},function (msg) {
                    console.log(msg);
                    if(msg=="true"){
                        location.reload();
                    }else{
                        layer.alert("操作失败，请重试");
                    }})}
            else {
                layer.alert("请输入正确的数字");
            }
        });
    }
function badmin(id) {

            layer.open({
                type: 2,
                area: ['600px', '450px'],
                content: '/bbs/admin/setadmin' ,
                title:'选择版块',
                btn: ['确认', '取消'],
                yes: function(index, layero){
                    var board = layer.getChildFrame('#board', index);
                    console.log(board.val());
                    if(board.val()==""){
                        layer.alert("请选择版块！");
                    }else{
                        $.post("/bbs/admin/set",{id:id,bid:board.val()},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                location.reload();
                            }else{
                                layer.alert("操作失败，请重试");
                            }})
                    layer.closeAll();}
                }
            });

}


</script>

</body>
</html>