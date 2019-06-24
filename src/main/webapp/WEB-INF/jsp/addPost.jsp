<%@page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"
        isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8"/>
    <title>帖子</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="stylesheet" href="/statics/layui/css/layui.css">
    <link rel="stylesheet" href="/statics/css/global.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<div style="height:300px;width:200px">
    <img src="/statics/images/ban3.jpg" alt="banner"/>
</div>
<br>

<div align="center">
    <c:if test="${not empty bid}">
        <a href="/bbs/board/${bid}" class="layui-btn">返回列表</a></c:if>
</div>

<div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20 style="padding-top: 5px;">
        <!--<div class="fly-none">没有权限</div>-->
        <div class="layui-form layui-form-pane">
            <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title">
                    <li class="layui-this">帖子<!-- 编辑帖子 --></li>
                </ul>
                <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                    <div class="layui-tab-item layui-show">
                        <form action="/bbs/post/addPost" method="post" enctype="multipart/form-data">
                            <div class="layui-row layui-col-space15 layui-form-item">

                                <c:if test="${empty notice}">
                                    <div class="layui-col-md3">
                                        <label class="layui-form-label">所在版块</label>
                                        <div class="layui-input-block">
                                            <select lay-verify="required" name="board" lay-filter="column" lay-search>

                                                <option></option>
                                                <c:forEach items="${board}" var="b">
                                                    <option value="${b.boardid}" <c:if test="${bid==b.boardid}"> selected </c:if> >${b.boardname}</option> </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="layui-col-md9">
                                    <label for="L_title" class="layui-form-label">标题</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="L_title"  name="title"
                                               value="${p.title}" required lay-verify="required" autocomplete="off"
                                               class="layui-input" maxlength="40">
                                        <input type="hidden" name="pid" value="${p.pid}">
                                    </div>
                                </div>
                            </div>
                            <!-- <div class="layui-row layui-col-space15 layui-form-item layui-hide" id="LAY_quiz">
                               <div class="layui-col-md3">
                                 <label class="layui-form-label">所属产品</label>
                                 <div class="layui-input-block">
                                   <select name="project">
                                     <option></option>
                                     <option value="layui">layui</option>
                                     <option value="独立版layer">独立版layer</option>
                                     <option value="独立版layDate">独立版layDate</option>
                                     <option value="LayIM">LayIM</option>
                                     <option value="Fly社区模板">Fly社区模板</option>
                                   </select>
                                 </div>
                               </div>
                               <div class="layui-col-md3">
                                 <label class="layui-form-label" for="L_version">版本号</label>
                                 <div class="layui-input-block">
                                   <input type="text" id="L_version" value="" name="version" autocomplete="off" class="layui-input">
                                 </div>
                               </div>
                               <div class="layui-col-md6">
                                 <label class="layui-form-label" for="L_browser">浏览器</label>
                                 <div class="layui-input-block">
                                   <input type="text" id="L_browser"  value="" name="browser" placeholder="浏览器名称及版本，如：IE 11" autocomplete="off" class="layui-input">
                                 </div>
                               </div>
                             </div>-->

                            <div class="layui-form-item layui-form-text">

                                <div class="layui-input-block">
                                    <label class="layui-form-label">文本域</label>
                                    <textarea id="text" name="content" required lay-verify="required"
                                              placeholder="详细描述,不超过850字" class="layui-textarea fly-editor"
                                              style="height: 260px;" maxlength="850">${main.content}</textarea>
                                </div>
                            </div>

                            <c:if test="${empty edit}">
                            <shiro:hasPermission name="Img">

                                <br><span>选完图片或附件的时候，记得点击上传，否则无效 。 点击上传后请勿再次点击  </span><br><br>

                                <button type="button" class="layui-btn" id="upi">
                                    <i class="layui-icon">&#xe67c;</i>选择图片
                                </button>

                                <button type="button" class="layui-btn" id="realupimg">开始上传</button>


                                <div class="layui-upload">
                                    <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
                                        预览图：
                                        <div class="layui-upload-list" id="yulan"></div>
                                    </blockquote>
                                </div>
                            </shiro:hasPermission>
                                <shiro:hasPermission name="File">
                                <br>

                                <br>
                                <br><span>附件支持格式：jpg、png、gif、bmp、jpeg、torrent、zip、rar、txt  </span><br><br>
                                <button type="button" class="layui-btn" id="upf">
                                    <i class="layui-icon">&#xe67c;</i>选择附件
                                </button>


                                <button type="button" class="layui-btn" id="realup">开始上传</button>
                                <span class="layui-inline layui-upload-choose" id="czfile"></span>

                                </shiro:hasPermission>
                            </c:if>


                            <br><br>
                            <input type="hidden" id="im" name="imgs" value="">
                            <input type="hidden" id="fi" name="files" value="">


                            <div class="layui-form-item">
                                <label for="L_scores" class="layui-form-label" style="width: 150px">下载附件所需积分</label>
                                <div class="layui-input-inline">
                                    <input type="text" id="L_scores" value="${p.scores}" oninput="score()" maxlength="2"
                                           name="scores" style="width: 250px" required lay-verify="required"
                                           placeholder="请输入0-50间的数字，若无附件填0" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button id="sub" class="layui-btn" lay-filter="*" lay-submit>提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%@ include file="/WEB-INF/jsp/footer.jsp" %>

<script>


    layui.use(['layer', 'form'], function () {
        var layer = layui.layer
            , form = layui.form;
    });

    function score() {
        var value = parseInt($("#L_scores").val());
        var sub = $("#sub");
        if (value > 50 || value < 0 || isNaN(value) || value == null) {
            sub.attr("disabled", "disabled");
            sub.attr("class", "layui-btn layui-btn-disabled")
        } else {
            sub.removeAttr("disabled");
            sub.attr("class", "layui-btn")
        }
    }


    layui.use('upload', function () {
        var upload = layui.upload;


        //执行实例
        var uploadInst = upload.render({
            elem: '#upi' //绑定元素
            , size: 2000
            , auto: false
            , multiple: true
            , bindAction: '#realupimg'
            , number: 7
            , url: '/bbs/post/upload' //上传接口
            , choose: function (obj) {
                $('#yulan').html("");
                $("#im").val("");
                var ri = $("#realupimg");
                ri.removeAttr("disabled");
                ri.attr("class", "layui-btn");
                //预读本地文件
                obj.preview(function (index, file, result) {

                    $('#yulan').append('<img src="' + result + '"  width="400" alt="' + file.name + '" class="layui-upload-img">')
                });
            }

            , before: function (obj) {
                var ri = $("#realupimg");
                ri.attr("disabled","disabled");
                ri.attr("class","layui-btn layui-btn-disabled")
            }

            , done: function (res) {
                $('#upi').html(" <i class=\"layui-icon\">&#xe67c;</i>重新选择")
                layui.use('layer', function () {
                    var layer = layui.layer;
                    layer.msg(res.message);
                })
                if (res.code == "success") {
                    var ri = $("#realupimg");
                    ri.attr("disabled", "disabled");
                    ri.attr("class", "layui-btn layui-btn-disabled")
                    $("#im").val($("#im").val() + res.filePath + ",")
                }
                //上传完毕回调
            }
            , error: function () {
                //请求异常回调

                $('#upi').html(" <i class=\"layui-icon\">&#xe67c;</i>重新选择")
                layui.use('layer', function () {
                    var layer = layui.layer;
                    layer.msg(res.message + "  请重试");
                })
                var ri = $("#realupimg");
                ri.removeAttr("disabled");
                ri.attr("class", "layui-btn")
            }
        });
    });


    layui.use('upload', function () {
        var upload = layui.upload;

        //执行实例
        var uploadInst = upload.render({
            elem: '#upf' //绑定元素
            , accept: 'file'
            , acceptMime: 'file/jpg,file/png,file/gif,file/bmp,file/jpeg,file/torrent,file/zip,file/rar,file/txt'
            , url: '/bbs/post/upload' //上传接口
            , exts: 'jpg|png|gif|bmp|jpeg|torrent|zip|rar|txt'
            , auto: false
            , size: 7000
            , multiple: true
            , bindAction: '#realup'
            , number: 5
            , choose: function (obj) {
                $("#fi").val("");
                $('#czfile').html("");
                var ri = $("#realup");
                ri.removeAttr("disabled");
                ri.attr("class", "layui-btn")

                obj.preview(function (index, file, result) {
                    $('#czfile').append(file.name + " ")
                });

            }  , before: function (obj) {
                var ri = $("#realup");
                ri.attr("disabled","disabled");
                ri.attr("class","layui-btn layui-btn-disabled")
            }
            , done: function (res) {
                $('#upf').html(" <i class=\"layui-icon\">&#xe67c;</i>重新选择")
                layui.use('layer', function () {
                    var layer = layui.layer;
                    layer.msg(res.message);
                })
                if (res.code == "success") {
                    var ri = $("#realup");
                    ri.attr("disabled", "disabled");
                    ri.attr("class", "layui-btn layui-btn-disabled")
                    $("#fi").val($("#fi").val() + res.filePath + ",")
                }
                //上传完毕回调
            }
            , error: function () {
                $('#upf').html(" <i class=\"layui-icon\">&#xe67c;</i>重新选择")
                layui.use('layer', function () {
                    var layer = layui.layer;
                    layer.msg(res.message + "  请重试");
                })
                var ri = $("#realup");
                ri.removeAttr("disabled");
                ri.attr("class", "layui-btn")
            }
        });
    });


</script>

</body>
</html>