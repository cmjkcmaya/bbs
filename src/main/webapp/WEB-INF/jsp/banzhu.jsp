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



  <div class="fly-panel fly-panel-user" pad20>
    <br> <br>

    <script type="text/javascript" src="/statics/js/jquery.js"></script>
    <script src="/statics/layui/layui.js"></script>

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
                ,title: '版主申请审核'
                ,url:'/bbs/admin/banzhusq'
                ,page:true
                ,cols: [[
                    {field:'aid',hide:true}
                    ,{field:'user.username', title:'用户名',templet: '<div><a href="/bbs/user/home?id={{d.user.id}}" target="_blank" class="layui-table-link">{{d.user.username}}</a></div>'}
                    ,{field:'board.boardname', title:'版块',templet: '<div><a href="/bbs/board/{{d.board.boardid}}" target="_blank" class="layui-table-link">{{d.board.boardname}}</a></div>'}
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
                        $.post("/bbs/admin/set",{id:data.user.id,bid:data.board.boardid},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })

                    });
                }else   if(obj.event === 'butongguo'){
                    layer.confirm('确定不通过吗', function(index){
                        layer.close(index);
                        $.post("/bbs/admin/noset",{aid:data.aid},function (msg) {
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