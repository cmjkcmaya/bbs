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


<script type="text/javascript" src="/statics/js/jquery.js"></script>
<script src="/statics/layui/layui.js"></script>


  <div class="fly-panel fly-panel-user" pad20>
	  <div class="layui-tab layui-tab-brief" lay-filter="user" id="LAY_msg" style="margin-top: 15px;">
        <c:if test="${not empty advise}" >
	    <button class="layui-btn layui-btn-danger" onclick="delall()" id="LAY_delallmsg">清空全部消息</button></c:if>

        <button class="layui-btn " onclick="quanti()" id="LAY_delallmsg">向全体用户发站内信</button>
        <button class="layui-btn " onclick="banzhu()" id="LAY_delallmsg">向全体版主发站内信</button>
	    <div  id="LAY_minemsg" style="margin-top: 10px;">
          <c:if test="${empty advise}" var="flag">
        <div class="fly-none">暂无记录</div></c:if>
          <c:if test="${not flag}">
        <ul class="mine-msg">
          <c:forEach items="${advise}" var="msg">
          <li>
            <blockquote class="layui-elem-quote">
              <a href="/bbs/user/home?id=${msg.poster.id}" target="_blank"><cite>${msg.poster.username}</cite></a>${msg.content}
            </blockquote>
            <p><span><fmt:formatDate value="${msg.ptime}" pattern="yyyy-MM-dd HH:mm"/></span>
                <a href="javascript:;"  onclick="del(${msg.aid})" class="layui-btn layui-btn-small layui-btn-danger fly-delete"  >删除</a>

             </p>
          </li>
          </c:forEach>

        </ul>
          </c:if>
      </div>
	  </div>
	</div>






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
    
    function quanti() {


        layer.prompt({
            formType: 2,
            value: '',
            title: '请输入内容',
            maxlength: 300,
            area: ['500px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            //do something
            layer.close(index);
            $.post("/bbs/admin/advise",{content:value,u:0},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    layer.alert("发送成功！",function () {
                        location.reload()
                    });

                }else{
                    layer.alert("发送失败，请重试");
                }})

        });

    }
    
    function banzhu() {
        layer.prompt({
            formType: 2,
            value: '',
            title: '请输入内容',
            maxlength: 300,
            area: ['500px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            //do something
            layer.close(index);
            $.post("/bbs/admin/advise",{content:value,u:-1},function (msg) {
                console.log(msg);
                if(msg=="true"){
                    layer.alert("发送成功！",function () {
                        location.reload()
                    });
                }else{
                    layer.alert("发送失败，请重试");
                }})

        });
    }
        
        function delall() {
            var layer = layui.layer;
            layer.confirm('确定清空吗?', {icon: 3, title: '提示'}, function (index) {
                layer.close(index);
                $.post("/bbs/admin/delall",function (msg) {
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