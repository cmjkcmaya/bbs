<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title></title>
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
    <br> <br>

    <div align="center" class="layui-input-block" style="float: left; position: relative;">
      <input style="width: auto;" type="text"  id="search" name="select_orderId" lay-verify="required" placeholder="请输入帖子标题" autocomplete="off" class="layui-input">
    </div>
    <button class="layui-btn" lay-submit="" onclick="sea()"  data-type="getInfo" style="float: left;">搜索</button>
    <br> <br> <br>


    <table class="layui-hide" id="test" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
      {{#  if(d.top==0){ }}
      <a class="layui-btn layui-btn-xs" lay-event="top">置顶</a>
      {{#  } if(d.top==1) {  }}
      <a class="layui-btn  layui-btn-xs" lay-event="notop">取消置顶</a>
      {{#  } if(d.good==0) {  }}
      <a class="layui-btn  layui-btn-xs" lay-event="good">加精</a>
      {{#  } if(d.good==1) {  }}
      <a class="layui-btn  layui-btn-xs" lay-event="nogood">取消加精</a>
      {{#  }   }}
      <a class="layui-btn  layui-btn-xs" lay-event="look" >查看</a>
      <a class="layui-btn  layui-btn-xs" lay-event="edit" >编辑</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>


    </script>
    <script type="text/html" id="toolbarDemo">
      <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delall">删除选中的帖子</button>
      </div>
    </script>



    <script>

        layui.use('layer');
        var layer = layui.layer;

        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#test'
                ,title: '用户管理'
                ,url:'/bbs/admin/postlist'
                ,page:true
                ,toolbar: '#toolbarDemo'
                ,defaultToolbar:[]
                ,cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field:'pid',hide:true}
                    ,{field:'title', title:'标题',templet: '<div><a href="/bbs/post/{{d.pid}}" target="_blank" class="layui-table-link">{{d.title}}</a></div>'}
                    ,{field:'board', title:'所在版块',templet: '<div><a href="/bbs/board/{{d.board.boardid}}" target="_blank" class="layui-table-link">{{d.board.boardname}}</a></div>'}
                    ,{field:'user', title:'作者',templet: '<div><a href="/bbs/user/home?id={{d.user.id}}" target="_blank" class="layui-table-link">{{d.user.username}}</a></div>'}

                    ,{field:'views', title:'查看次数'}
                    ,{field:'replies', title:'回复数'}
                    ,{field:'good', title:'是否是精品帖',width:150 ,templet:  function(d){
                        if(d.good==1){return '是'}else{return '否'}

                        }}
                    ,{field:'top', title:'是否被置顶',width:150 ,templet:function(d){
                            if(d.top==1){return '是'}else{return '否'}

                        }}
                   , {field:'addtime', title:'发帖时间',width:150 ,templet:function (res) {
                            var date = new Date(res.addtime);
                            Y = date.getFullYear() + '-';
                            M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
                            D = (date.getDate()<10?'0'+(date.getDate()):date.getDate()) + ' ';
                            h = (date.getHours() <10?'0'+(date.getHours()):date.getHours())+ ':';
                            m = date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes();
                            //      s = date.getSeconds();
                            return Y+M+D+h+m;
                        }}
                    , {field:'retime', title:'最后回复时间',width:150 ,templet:function (res) {
                            var date = new Date(res.retime);
                            Y = date.getFullYear() + '-';
                            M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
                            D = (date.getDate()<10?'0'+(date.getDate()):date.getDate()) + ' ';
                            h = (date.getHours() <10?'0'+(date.getHours()):date.getHours())+ ':';
                            m = date.getMinutes()<10?'0'+date.getMinutes():date.getMinutes();
                            //      s = date.getSeconds();
                            return Y+M+D+h+m;
                        }}
                    ,{fixed: 'right', width: 400, title:'操作', toolbar: '#barDemo'}
                ] ]
            });


            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'delall':
                        var data = checkStatus.data;
                        var ids='';
                        for(var i=0;i<data.length;i++){
                            ids=ids+data[i].pid+','
                        }

                        layer.confirm('确定要删除选中的帖子么', function(index){
                            layer.close(index);
                            $.post("/bbs/post/delall",{ids:ids},function (msg) {
                                console.log(msg);
                                if(msg=="true"){
                                    table.reload('test', {
                                    });
                                }else{
                                    layer.alert("操作失败，请重试");
                                }
                            })
                        })

                        console.log(ids)
                        break;

                };
            });


            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'top'){
                    layer.confirm('确定要置顶该帖子么', function(index){
                        layer.close(index);
                        $.post("/bbs/user/settop",{pid:data.pid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    })
                }
                if(obj.event === 'notop'){
                    layer.confirm('确定要取消置顶么', function(index){
                        layer.close(index);
                        $.post("/bbs/user/canceltop",{pid:data.pid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    })
                }
                if(obj.event === 'good'){
                    layer.confirm('确定要加精吗', function(index){
                        layer.close(index);
                        $.post("/bbs/user/tongguo",{pid:data.pid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    })
                }
                if(obj.event === 'nogood'){
                    layer.confirm('确定取消加精吗', function(index){
                        layer.close(index);
                        $.post("/bbs/user/cancelgood",{pid:data.pid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    })
                }
                if(obj.event === 'look'){
                    window.open('/bbs/post/'+data.pid,'_blank')
                }
                if(obj.event === 'edit'){
                    window.open('/bbs/post/editpost?pid='+data.pid,'_blank')
                }
                if(obj.event === 'del'){
                    layer.confirm('确定要删除该帖子么', function(index){
                        layer.close(index);
                        $.post("/bbs/post/delp",{pid:data.id},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    })
                }

            });
        });
        
        function sea() {
            layui.use('table', function(){
                var table = layui.table;
            table.reload('test', {
                where: {search:$('#search').val()}

            });})
        }
        
    </script>

  </div>






</body>
</html>