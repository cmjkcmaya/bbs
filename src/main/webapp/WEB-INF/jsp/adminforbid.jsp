<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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


  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user" pad20>

    <br> <br>
    <table class="layui-hide" id="test" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
      {{#  if(d.handle==1){ }}
      <a class="layui-btn layui-btn-xs" lay-event="jiejin">解禁</a>
      {{# }  else{ }}
      <a class="layui-btn  layui-btn-xs" lay-event="jiefeng">解封</a>
      {{# } }}
    </script>

    <script>

        layui.use('layer');
        var layer = layui.layer;

        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#test'
                ,title: ''
                ,url:'/bbs/admin/fuser'
                ,page:true
                ,cols: [[
                    {field:'fid',hide:true}
                    ,{field:'user.username', title:'用户',templet: '<div><a href="/bbs/user/home?id={{d.user.id}}"  target="_blank" class="layui-table-link">{{d.user.username}}</a></div>'}
                    ,{field:'handler.username', title:'处理人',templet: '<div><a href="/bbs/user/home?id={{d.handler.id}}"  target="_blank" class="layui-table-link">{{d.handler.username}}</a></div>'}
                    ,{field:'handle', title:'禁言还是封禁',width:200 ,templet:function(d){
                            if(d.handle==1){return '禁言'}else{return '封禁'}

                        }}
                    ,{field:'ftime', title:'解禁时间',templet:function (res) {
                            var date = new Date(res.ftime);
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
                if(obj.event === 'jiejin'){
                    layer.confirm('确定解禁么', function(index){
                        layer.close(index);
                        $.post("/bbs/user/jiejin",{id:data.user.id,fid:data.fid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                location.reload();
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    });
                }
                if(obj.event === 'jiefeng'){
                    layer.confirm('确定解封么', function(index){
                        layer.close(index);
                        $.post("/bbs/user/jiefeng",{id:data.id,fid:data.fid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
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






</body>
</html>