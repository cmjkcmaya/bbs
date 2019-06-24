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
    <br>
    <button class="layui-btn " onclick="add()" id="LAY_delallmsg">新增版块</button>
    <br> <br>
    <table class="layui-hide" id="test" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
      {{#  if(d.boardadmin==null){ }}
      <a class="layui-btn layui-btn-xs" lay-event="seta">设置版主</a>
      {{# }  else{ }}
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="noset">撤除版主</a>
      {{# } }}
      <a class="layui-btn  layui-btn-xs" lay-event="xiugai">修改</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>

    <script>

        layui.use('layer');
        var layer = layui.layer;

        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#test'
                ,title: ''
                ,url:'/bbs/admin/boardlist'
                ,page:true
                ,cols: [[
                    {field:'boardid',hide:true}
                    ,{field:'boardname', title:'版块名',templet: '<div><a href="/bbs/board/{{d.boardid}}"  target="_blank" class="layui-table-link">{{d.boardname}}</a></div>'}
                    ,{field:'boardadmin', title:'版主',templet:function (d) {
                            if(d.boardadmin==null) return ""; else
                            {return '<div><a href="/bbs/user/home?id='+d.boardadmin.id+'"  target="_blank" class="layui-table-link">'+d.boardadmin.username+'</a></div>'}
                        }}
                   ,{field:'postnum', title:'帖子数量'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo'}
                ] ]
            });

            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'seta'){
                    layer.open({
                        type: 2,
                        area: ['600px', '450px'],
                        content: '/bbs/admin/ul' ,
                        title:'选择用户',
                        btn: ['确认', '取消'],
                        yes: function(index, layero){
                            var user = layer.getChildFrame('#user', index);
                            console.log(user.val());
                            if(user.val()==""){
                                layer.alert("请选择用户！");
                            }else{
                                $.post("/bbs/admin/set",{bid:data.boardid,id:user.val()},function (msg) {
                                    console.log(msg);
                                    if(msg=="true"){
                                        table.reload('test', {
                                        });
                                    }else{
                                        layer.alert("操作失败，请重试");
                                    }})
                                layer.closeAll();}
                        }
                    });
                }
                if(obj.event === 'noset'){
                    layer.confirm('确定撤除么', function(index){
                        layer.close(index);
                        $.post("/bbs/admin/chechu",{bid:data.boardid,id:data.boardadmin.id},function (msg) {
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
                if(obj.event === 'xiugai') {
                    layer.prompt({
                        formType: 0,
                        value: data.boardname,
                        title: '请修改版块名',
                        maxlength: 45
                    }, function (value, index, elem) {
                            layer.close(index);
                            $.post("/bbs/admin/xgb", {bid:data.boardid,name:value}, function (msg) {
                                console.log(msg);
                                if (msg == "true") {
                                    table.reload('test', {
                                    });
                                } else {
                                    layer.alert("操作失败，请重试");
                                }
                            })

                    });
                }
                if(obj.event === 'del') {
                    layer.confirm('确定删除么', function(index){
                        layer.close(index);
                        $.post("/bbs/admin/delb",{bid:data.boardid},function (msg) {
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


function add() {
    layer.prompt({
        formType: 0,
        value:'',
        title: '请输入版块名',
        maxlength: 45
    }, function (value, index, elem) {
        layer.close(index);
        $.post("/bbs/admin/addb", {name:value}, function (msg) {
            console.log(msg);
            if (msg == "true") {
               location.reload()
            } else {
                layer.alert("操作失败，请重试");
            }
        })

    });
}
    </script>



  </div>






</body>
</html>