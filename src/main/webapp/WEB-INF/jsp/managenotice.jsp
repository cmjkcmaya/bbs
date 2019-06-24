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
    <br>
    <button class="layui-btn " onclick="add()" id="LAY_delallmsg">发布公告帖</button>
    
    <br> <br>

   <!-- <div align="center" class="layui-input-block" style="float: left; position: relative;">
      <input style="width: auto;" type="text"  id="search" name="select_orderId" lay-verify="required" placeholder="请输入帖子标题" autocomplete="off" class="layui-input">
    </div>
    <button class="layui-btn" lay-submit="" onclick="sea()"  data-type="getInfo" style="float: left;">搜索</button>
    <br> <br> <br>-->


    <table class="layui-hide" id="test" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
      <a class="layui-btn  layui-btn-xs" lay-event="look" >查看</a>
      <a class="layui-btn  layui-btn-xs" lay-event="edit" >编辑</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>




    <script>

        layui.use('layer');
        var layer = layui.layer;

        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#test'
                ,title: '用户管理'
                ,url:'/bbs/admin/noticelist'
                ,page:true
                ,cols: [[
                    {field:'pid',hide:true}
                    ,{field:'title', title:'标题',templet: '<div><a href="/bbs/post/notice/{{d.pid}}" target="_blank" class="layui-table-link">{{d.title}}</a></div>'}
                    ,{field:'user', title:'作者',templet: '<div><a href="/bbs/user/home?id={{d.user.id}}" target="_blank" class="layui-table-link">{{d.user.username}}</a></div>'}
                    ,{field:'views', title:'查看次数'}
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
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo'}
                ] ]
            });


            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)

                if(obj.event === 'look'){
                    window.open('/bbs/post/notice/'+data.pid,'_blank')
                }
                if(obj.event === 'edit'){
                    window.open('/bbs/post/editpost?pid='+data.pid,'_blank')
                }
                if(obj.event === 'del'){
                    layer.confirm('确定要删除该帖子么', function(index){
                        layer.close(index);
                        $.post("/bbs/post/deln",{pid:data.pid},function (msg) {
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
        

        function add() {
            layer.open({
                type: 2,
                area: ['1000px', '600px'],
                content: '/bbs/admin/addnotice' ,
                title:'发布公告帖',

            });
        }
    </script>

  </div>






</body>
</html>