<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>举报处理</title>
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
    <li class="layui-nav-item">
      <a href="/bbs/user/level">
        <i class="layui-icon">&#xe611;</i>
        我的等级权限
      </a>
    </li>

    <c:if test="${user.roleflag==6||user.roleflag==7}">
    <li class="layui-nav-item layui-this">
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
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">被举报的用户</li>
        <li data-type="mine-jie" lay-id="index" class="">被举报的帖子</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <table class="layui-hide" id="test" lay-filter="test"></table>

          <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="jinyan">禁言</a>
            <a class="layui-btn layui-btn-xs" lay-event="del">不处理</a>
          </script>

          <script>

              layui.use('layer');
              var layer = layui.layer;

              layui.use('table', function(){
                  var table = layui.table;

                  table.render({
                      elem: '#test'
                      ,title: '被举报的用户'
                      ,url:'/bbs/user/ruser'
                      ,page:true
                      ,cols: [[
                          {field:'reid',hide:true}
                          ,{field:'user.username', title:'被举报的用户', width:120,templet: '<div><a href="/bbs/user/home?id={{d.user.id}}"  target="_blank" class="layui-table-link">{{d.user.username}}</a></div>'}
                          ,{field:'reason', title:'举报理由', width:370}
                          ,{field:'rtime', title:'举报时间', width:150,templet:function (res) {
                                  var date = new Date(res.rtime);
                                  Y = date.getFullYear() + '-';
                                  M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
                                  D = (date.getDate()<10?'0'+(date.getDate()):date.getDate()) + ' ';
                                  h = (date.getHours() <10?'0'+(date.getHours()):date.getHours())+ ':';
                                  m = date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes();
                          //      s = date.getSeconds();
                                  return Y+M+D+h+m;
                              }}
                          ,{field:'reuser.username', title:'举报者', width:120,templet: '<div><a href="/bbs/user/home?id={{d.reuser.id}}" target="_blank" class="layui-table-link">{{d.reuser.username}}</a></div>'}
                          ,{fixed: 'right', title:'操作', toolbar: '#barDemo'}
                     ] ]
                  });

                  //监听行工具事件
                  table.on('tool(test)', function(obj){
                      var data = obj.data;
                      //console.log(obj)
                      if(obj.event === 'del'){
                          layer.confirm('确定不处理么', function(index){

                              layer.close(index);
                              $.post("/bbs/user/ignoreu",{id:data.reid},function (msg) {
                                  console.log(msg);
                                  if(msg=="true"){
                                      location.reload();
                                  }else{
                                      layer.alert("操作失败，请重试");
                                  }
                              })

                          });
                      } else if(obj.event === 'jinyan'){
                          layer.prompt({
                              formType: 0,
                              value: '',
                              title: '请输入天数（1到30天）',
                              maxlength: 2

                          }, function(value, index, elem){

                              value=parseInt(value);
                              if(value<=30&&value>=1){
                                  layer.close(index);
                                  $.post("/bbs/user/forbidu",{day:value,id:data.user.id},function (msg) {
                                      console.log(msg);
                                      if(msg=="true"){
                                          location.reload();
                                      }else{
                                          layer.alert("操作失败，请重试");
                                      }})}
                              else {
                                  layer.alert("请输入正确天数");
                              }
                          });}});});
          </script>

        </div>

        <div class="layui-tab-item ">

            <table class="layui-hide" id="test1" lay-filter="test1"></table>


            <script type="text/html" id="barDemo1">

                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del1">删除</a>
                <a class="layui-btn layui-btn-xs" lay-event="buchuli">不处理</a>
            </script>


            <script>
              /*  {{#  if(d.post.pid==2){ }}
                <a class="layui-btn layui-btn-xs" lay-event="cancel">撤销</a>
                    {{#  } else {  }}
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del1">删除</a>
                    <a class="layui-btn layui-btn-xs" lay-event="buchuli">不处理</a>
                    {{#  }  }}*/
                layui.use('table', function(){
                    var table = layui.table;

                    table.render({
                        elem: '#test1'
                        ,title: '被举报的帖子'
                        ,url:'/bbs/user/rpost'
                        ,page:true
                        ,cols: [[
                            {field:'reid',hide:true}
                            ,{field:'post.title', title:'被举报的帖子', width:150,templet: '<div><a href="/bbs/post/{{d.post.pid}}" target="_blank" class="layui-table-link">{{d.post.title}}</a></div>'}
                            ,{field:'reason', title:'举报理由', width:370}
                            ,{field:'rtime', title:'举报时间', width:150,templet:function (res) {
                                    var date = new Date(res.rtime);
                                    Y = date.getFullYear() + '-';
                                    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
                                    D = (date.getDate()<10?'0'+(date.getDate()):date.getDate()) + ' ';
                                    h = (date.getHours() <10?'0'+(date.getHours()):date.getHours())+ ':';
                                    m = date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes();
                                    //      s = date.getSeconds();
                                    return Y+M+D+h+m;
                                }}
                            ,{field:'reuser.username', title:'举报者', width:100,templet: '<div><a href="/bbs/user/home?id={{d.reuser.id}}"  target="_blank" class="layui-table-link">{{d.reuser.username}}</a></div>'}
                            ,{fixed: 'right', title:'操作', toolbar: '#barDemo1'}
                        ] ]
                    });

                    //监听行工具事件
                    table.on('tool(test1)', function(obj){
                        var data = obj.data;
                        //console.log(obj)
                        if(obj.event === 'del1'){
                            layer.confirm('确定要删除该帖子么', function(index){
                                layer.close(index);
                                $.post("/bbs/post/delp",{pid:data.post.pid},function (msg) {
                                    console.log(msg);
                                    if(msg=="true"){
                                        location.reload();
                                    }else{
                                        layer.alert("操作失败，请重试");
                                    }
                                })
                            });
                        } else if(obj.event === 'buchuli'){
                            layer.confirm('确定不处理么', function(index){
                                layer.close(index);
                                $.post("/bbs/user/ignorep",{id:data.reid},function (msg) {
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
    </div>
  </div>
</div>


<%@ include file="/WEB-INF/jsp/footer.jsp"%>


</body>
</html>