<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>帐号设置</title>
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
    <li class="layui-nav-item layui-this">
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
      <li class="layui-nav-item">
        <a href="/bbs/user/good">
          <i class="layui-icon">&#xe611;</i>
          精品帖申请处理
        </a>
      </li>
    </c:if>

  </ul>

  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  <div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
  </div>
  <div class="site-mobile-shade"></div>
  
  
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li class="layui-this" lay-id="info">我的资料</li>
        <li lay-id="avatar">头像</li>
        <li lay-id="pass">密码</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-form layui-form-pane layui-tab-item layui-show">
          <form action="/bbs/user/update" method="post">
            <div class="layui-form-item">
              <label for="L_email" class="layui-form-label">邮箱</label>
              <div class="layui-input-inline">
                <input type="text" id="L_email" name="email"  maxlength="60"  pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}" oninvalid="setCustomValidity('格式错误')"  oninput="setCustomValidity('')"    required lay-verify="email" autocomplete="off" value="${user.email}" class="layui-input">
              </div>
            </div>
            <div class="layui-form-item">
              <div class="layui-inline">
                <div class="layui-input-inline">
                  <input type="radio" name="sex" value="男" <c:if test='${user.sex=="男"}'>checked</c:if> title="男">
                  <input type="radio" name="sex" value="女" <c:if test='${user.sex=="女"}'>checked</c:if> title="女">
                </div>
              </div>
            </div>
            <div class="layui-form-item ">
              <label for="L_sign" class="layui-form-label">签名</label>
              <div class="layui-input-inline">
                <input type="text" placeholder="随便写些什么刷下存在感" id="L_sign"  maxlength="45" name="msg" autocomplete="off" class="layui-input" style="width: 500px;" value="${user.msg}">
              </div>
            </div>
            <div class="layui-form-item">
              <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit>确认修改</button>
            </div></form>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">
            <div class="layui-form-item">
              <div class="avatar-add">
                <p>支持jpg、png、gif</p>
                <button type="button" id="upi" class="layui-btn upload-img">
                <i class="layui-icon">&#xe67c;</i>上传头像
              </button>
                <img id="img"  src="/statics/images/avatar/${user.head}">
                <input type="hidden" id="head" value="${user.head}">
                <span class="loading"></span>
              </div>
              <br>
              <br>
              <button type="button" disabled id="xg" onclick="xiugai()" class="layui-btn layui-btn-disabled">
                确认修改
              </button>
            </div>
          </div>
          
          <div class="layui-form layui-form-pane layui-tab-item">

              <div class="layui-form-item">
                <label for="L_nowpass" class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_nowpass" name="nowpass" maxlength="30" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label for="password" class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="password" maxlength="30" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>

              </div>
              <div class="layui-form-item">
                <label for="password1" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="password1" maxlength="30" name="repass" required lay-verify="required"  oninput="querenmima()" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux" id="error1"></div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" id="zc" onclick="psw()">确认修改</button>
              </div>

          </div>
          
         <!-- <div class="layui-form layui-form-pane layui-tab-item">
            <ul class="app-bind">
              <li class="fly-msg app-havebind">
                <i class="iconfont icon-qq"></i>
                <span>已成功绑定，您可以使用QQ帐号直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="qq_id">解除绑定</a>
                
                <!-- <a href="" onclick="layer.msg('正在绑定微博QQ', {icon:16, shade: 0.1, time:0})" class="acc-bind" type="qq_id">立即绑定</a>
                <span>，即可使用QQ帐号登录Fly社区</span>
              </li>
              <li class="fly-msg">
                <i class="iconfont icon-weibo"></i>
                <!-- <span>已成功绑定，您可以使用微博直接登录Fly社区，当然，您也可以</span>
                <a href="javascript:;" class="acc-unbind" type="weibo_id">解除绑定</a>
                
                <a href="" class="acc-weibo" type="weibo_id"  onclick="layer.msg('正在绑定微博', {icon:16, shade: 0.1, time:0})" >立即绑定</a>
                <span>，即可使用微博帐号登录Fly社区</span>
              </li>
            </ul>
          </div>-->
        </div>

      </div>
    </div>
  </div>
</div>



<%@ include file="/WEB-INF/jsp/footer.jsp"%>


<script>

    function querenmima() {
        if($("#password").val()!=$("#password1").val()){
            $("#error1").html("输入不一致");
            $("#zc").attr("disabled","disabled");
            $("#zc").attr("class", "layui-btn layui-btn-disabled")
        }else{
            $("#error1").html("");
            $("#zc").removeAttr("disabled");
            $("#zc").attr("class", "layui-btn")
        }
    };


    layui.use( 'form', function () {
        var form = layui.form;
    });


    layui.use('upload', function () {
        var upload = layui.upload;


        //执行实例
        var uploadInst = upload.render({
            elem: '#upi' //绑定元素
            , size: 2000
            , auto: true
            , multiple: false
            , url: '/bbs/user/upload' //上传接口
            , choose: function (obj) {
                $("#head").val("");

                //预读本地文件
                obj.preview(function (index, file, result) {

                    $('#img').attr("src",result);
                });
            }

            , before: function (obj) {
                var ri = $("#xg");
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
                    var ri = $("#xg");
                    ri.removeAttr("disabled");
                    ri.attr("class", "layui-btn")
                    $("#head").val(res.filePath)
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
            }
        });
    });

    layui.use('layer');
    var layer = layui.layer;
function xiugai() {
    layer.msg("修改中，请稍后");
    $.post("/bbs/user/xgtx",{head:$("#head").val()},function (msg) {
        console.log(msg);
        if(msg=="true"){
            location.reload();
        }else{
             layer.alert("修改失败，请重试");
        }
    })
}

    function psw() {
        layer.msg("修改中，请稍后");
        $.post("/bbs/user/psw",{psw:$("#password").val(),pnow:$("#L_nowpass").val()},function (msg) {
            console.log(msg);
            if(msg=="true"){
                self.location="/bbs/login";
            }else{if(msg=="no"){
                layer.alert("原密码错误！");}else{
                layer.alert("修改失败，请重试");
            }
            }
        })
    }


</script>

</body>
</html>