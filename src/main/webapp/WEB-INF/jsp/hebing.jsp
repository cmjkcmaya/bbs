<%@page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html;charset=UTF-8"   isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/statics/layui/css/layui.css">
</head>
<body>

<script type="text/javascript" src="/statics/js/jquery.js"></script>
<script src="/statics/layui/layui.js"></script>
<script>

    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
            ,form = layui.form;
    });

    layer=layui.layer;
</script>
<br>
<div align="center">
<form class="layui-form" action="">
    <!--<input type="hidden" id="name" value="11">-->

    <div class="layui-input-block" style="height:300px;width:200px">
        请选择合并的主版块：<br><br>
        <select id="board1"   lay-verify="required" lay-search>
                <option value=""></option>
          <c:forEach items="${boards}" var="board">
    <option value="${board.boardid}">${board.boardname}</option>
                </c:forEach>

            </select>

<br > <br>
        请选择被合并的版块：<br><br>
        <select id="board2"   lay-verify="required" lay-search>
            <option value=""></option>
            <c:forEach items="${boards}" var="board">
                <option value="${board.boardid}">${board.boardname}</option>
            </c:forEach>

        </select>
        <br> <br>
        <a id="sub"  onclick="hb()" class="layui-btn">提交</a>

    </div>




</form>
</div>
<script>
function hb(){
    layer.confirm('确定合并么', function(index){
        var b1=$('#board1').val();
        var b2=$('#board2').val();
if(b1==''||b2==''){layer.alert("两个版块不能为空！");}else{
        if(b1==b2){
            layer.alert("两个版块不能一样！");
        }else{
        layer.close(index);
        $.post("/bbs/admin/hebing",{id1:b1,id2:b2},function (msg) {
            console.log(msg);
            if(msg=="true"){
                layer.alert("合并成功！",function () {
                    location.reload();
                });
            }else{
                layer.alert("操作失败，请重试");
            }
        })}}
    });}
</script>

</body>
</html>
