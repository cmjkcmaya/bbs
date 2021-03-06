<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>精帖申请处理</title>
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
      <li class="layui-nav-item layui-this" >
      <a href="/bbs/user/good">
        <i class="layui-icon">&#xe611;</i>
        精品帖申请处理
      </a>
      </li>
      </c:if>


  </ul>

  
  
  <div class="fly-panel fly-panel-user" pad20>
    <br> <br>

   <!-- <div align="center" class="layui-input-block" style="float: left; position: relative;">
      <input style="width: auto;" type="text" id="select_orderId" name="select_orderId" lay-verify="required" placeholder="请输入订单编号" autocomplete="off" class="layui-input">
    </div>
    <button class="layui-btn" lay-submit="" id="searchBtn" data-type="getInfo" style="float: left;">搜索</button>
    <br> <br> <br>-->


    <table class="layui-hide" id="test" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
      <a class="layui-btn layui-btn-xs" lay-event="tongguo">通过</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="butongguo">不通过</a>
    </script>

    <script>

        layui.use('layer');
        var layer = layui.layer;

        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#test'
                ,title: '精品帖申请处理'
                ,url:'/bbs/user/goodsq'
                ,page:true
                ,cols: [[
                    {field:'aid',hide:true}
                    ,{field:'post.title', title:'申精的帖子', width:150,templet: '<div><a href="/bbs/post/{{d.post.pid}}" target="_blank" class="layui-table-link">{{d.post.title}}</a></div>'}
                   , {field:'reason', title:'申请理由', width:370}
                    ,{field:'atime', title:'申请时间',templet:function (res) {
                            var date = new Date(res.atime);
                            Y = date.getFullYear() + '-';
                            M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
                            D = (date.getDate()<10?'0'+(date.getDate()):date.getDate()) + ' ';
                            h = (date.getHours() <10?'0'+(date.getHours()):date.getHours())+ ':';
                            m = date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes();
                            //      s = date.getSeconds();
                            return Y+M+D+h+m;
                        }}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo'}
                ] ]
            });

            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'tongguo'){
                    layer.confirm('确定通过吗', function(index){
                        layer.close(index);
                        $.post("/bbs/user/tongguo",{pid:data.post.pid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                location.reload();
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })

                    });
                }else   if(obj.event === 'butongguo'){
                    layer.confirm('确定不通过吗', function(index){
                        layer.close(index);
                        $.post("/bbs/user/butongguo",{id:data.aid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                location.reload();
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    });
                }
            });
        });
    </script>

  </div>
</div>


<%@ include file="/WEB-INF/jsp/footer.jsp"%>



</body>
</html>