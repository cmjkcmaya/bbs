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
      <input style="width: auto;" type="text"  id="search" name="select_orderId" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
    </div>
    <button class="layui-btn" lay-submit="" onclick="sea()"  data-type="getInfo" style="float: left;">搜索</button>
    <br> <br> <br>


    <table class="layui-hide" id="test" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
      {{#  if(d.forbid==0&&d.roleflag!=7){ }}
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="jinyan">禁言</a>
      {{#  } if(d.forbid==1) {  }}
      <a class="layui-btn  layui-btn-xs" lay-event="jiejin">解禁</a>
      {{#  } if(d.block==0&&d.roleflag!=7) {  }}
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="fengjin">封禁</a>
      {{#  } if(d.block==1) {  }}
      <a class="layui-btn  layui-btn-xs" lay-event="jiefeng">解封</a>
      {{#  } if(d.score>0&&d.roleflag!=7) {  }}
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="kouchu">扣除积分</a>
      {{#  }}}
      <a class="layui-btn  layui-btn-xs" lay-event="zhanneixin">发站内信</a>
      <a class="layui-btn  layui-btn-xs" lay-event="jiangli">奖励积分</a>
      <a class="layui-btn  layui-btn-xs" lay-event="level">修改等级</a>

    </script>




    <script>

        layui.use('layer');
        var layer = layui.layer;

        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#test'
                ,title: '用户管理'
                ,url:'/bbs/admin/userlist'
                ,page:true
                ,cols: [[
                    {field:'id',hide:true}
                    ,{field:'username', title:'用户名',templet: '<div><a href="/bbs/user/home?id={{d.id}}" target="_blank" class="layui-table-link">{{d.username}}</a></div>'}
                   , {field:'sex', width:70 , title:'性别'}
                    ,{field:'email', title:'电子邮箱'}
                    ,{field:'exp', width:80 ,title:'经验值'}
                    ,{field:'score',width:70 , title:'积分'}
                    ,{field:'msg', title:'签名'}
                    ,{field:'forbid', title:'是否被禁言',width:100 ,templet:  function(d){
                        if(d.forbid==1){return '是'}else{return '否'}

                        }}
                    ,{field:'block', title:'是否被封禁',width:100 ,templet:function(d){
                            if(d.block==1){return '是'}else{return '否'}

                        }}
                    ,{field:'roleflag', title:'身份',width:100 ,templet:function(d){
                            if(d.roleflag==0){return '普通用户'}
                            if(d.roleflag==6){return '版主'}
                            if(d.roleflag==7){return '管理员'}
                        }

                    }
                   , {field:'logintime', title:'最后登录时间',width:150 ,templet:function (res) {
                            var date = new Date(res.logintime);
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

            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'jinyan'){
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入天数（1到30天）',
                        maxlength: 2

                    }, function(value, index, elem){

                        value=parseInt(value);
                        if(value<=30&&value>=1){
                            layer.close(index);
                            $.post("/bbs/user/forbidu",{day:value,id:data.id},function (msg) {
                                console.log(msg);
                                if(msg=="true"){
                                    table.reload('test', {
                                        where: {search:$('#search').val()}
                                    });
                                }else{
                                    layer.alert("操作失败，请重试");
                                }})}
                        else {
                            layer.alert("请输入正确天数");
                        }
                    });
                }
                if(obj.event === 'jiejin'){
                    layer.confirm('确定解禁么', function(index){
                        layer.close(index);
                        $.post("/bbs/user/jiejin",{id:data.id},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                    where: {search:$('#search').val()}
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    });
                }
                if(obj.event === 'fengjin'){
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入天数（1到30天）',
                        maxlength: 2

                    }, function(value, index, elem){

                        value=parseInt(value);
                        if(value<=30&&value>=1){
                            layer.close(index);
                            $.post("/bbs/user/block",{day:value,id:data.id},function (msg) {
                                console.log(msg);
                                if(msg=="true"){
                                    table.reload('test', {
                                        where: {search:$('#search').val()}
                                    });
                                }else{
                                    layer.alert("操作失败，请重试");
                                }})}
                        else {
                            layer.alert("请输入正确天数");
                        }
                    });
                }
                if(obj.event === 'jiefeng'){
                    layer.confirm('确定解封么', function(index){
                        layer.close(index);
                        $.post("/bbs/user/jiefeng",{id:data.id},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                    where: {search:$('#search').val()}
                                });
                            }else{
                                layer.alert("操作失败，请重试");
                            }
                        })
                    });
                }
                if(obj.event === 'kouchu'){
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入要扣除的分数（1到20分）',
                        maxlength: 2
                    }, function(value, index, elem){

                        value=parseInt(value);
                        if(value<=20&&value>=1){
                            layer.close(index);
                            $.post("/bbs/user/score",{score:'-'+value,id:data.id},function (msg) {
                                console.log(msg);
                                if(msg=="true"){
                                    table.reload('test', {
                                        where: {search:$('#search').val()}
                                    });
                                }else{
                                    layer.alert("操作失败，请重试");
                                }})}
                        else {
                            layer.alert("请输入正确的数字");
                        }
                    });
                }
                if(obj.event === 'zhanneixin'){

                    layer.prompt({
                        formType: 2,
                        value: '',
                        title: '请输入内容',
                        maxlength: 300,
                        area: ['500px', '100px'] //自定义文本域宽高
                    }, function(value, index, elem){
                        //do something
                        layer.close(index);
                        $.post("/bbs/user/zhanneixin",{content:value,id:data.id},function (msg) {
                            console.log(msg);
                            if(msg=="true"){
                                table.reload('test', {
                                    where: {search:$('#search').val()}
                                });
                            }else{
                                layer.alert("发送失败，请重试");
                            }})

                    });
                }
                if(obj.event === 'jiangli'){
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入要给予的分数（1到20分）',
                        maxlength: 2
                    }, function(value, index, elem){
                        value=parseInt(value);
                        if(value<=20&&value>=1){
                            layer.close(index);
                            $.post("/bbs/user/score",{score:value,id:data.id},function (msg) {
                                console.log(msg);
                                if(msg=="true"){
                                    table.reload('test', {
                                        where: {search:$('#search').val()}
                                    });
                                }else{
                                    layer.alert("操作失败，请重试");
                                }})}
                        else {
                            layer.alert("请输入正确的数字");
                        }
                    });
                }
                if(obj.event === 'level'){
                    layer.prompt({
                        formType: 0,
                        value: '',
                        title: '请输入等级（1-5）',
                        maxlength: 1
                    }, function(value, index, elem){
                        value=parseInt(value);
                        if(value<=5&&value>=1){
                            layer.close(index);
                            $.post("/bbs/user/dengji",{lv:value,id:data.id},function (msg) {
                                console.log(msg);
                                if(msg=="true"){
                                    table.reload('test', {
                                        where: {search:$('#search').val()}
                                    });
                                }else{
                                    layer.alert("操作失败，请重试");
                                }})}
                        else {
                            layer.alert("请输入正确的数字");
                        }
                    });
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