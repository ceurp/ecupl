<!DOCTYPE html>
<html lang="zh_CN">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="content-style-type" content="text/css"/>
    <meta http-equiv="content-script-type" content="text/javascript"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>华东政法大学继续教育学院教学认证系统</title>
    <link rel="stylesheet" href="${static_base}/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${static_base}/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="${static_base}/platform/0.0.5/css/login.css?v=20180414" />
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

<div class="logindiv">
    <div style="position : absolute;top : 15px;left : 20px;">
    <image style="width:532px;height:80px" src="${static_base}/platform/0.0.5/images/banner1.jpg"/>
    </div>
    <div class="banner2"></div>
    <form name="loginForm" action="${base}/cas/login"  enctype="multipart/form-data" target="_top" method="post">
    [#if Parameters['sid_name']??]
      <input type="hidden" name="sid_name" value="${Parameters['sid_name']}">
    [/#if]
    [#if Parameters['service']??]
    <input type="hidden" name="service" value="${Parameters['service']}">
    [/#if]
        <table class="bulletin">
            <tr>
                <td>
                <image style="width:530px;height:230px" src="${static_base}/platform/0.0.5/images/tu2.jpg"/>
                </td>
            </tr>
        </table>
        <table class="logintable">
            <tr style="height:30px">
                <td colspan="2" style="text-align:center;color:red;">${error!}</td>
            </tr>
            <tr>
                <td><label for="username">用户名:&nbsp;</label></td>
                <td>
                    <input name="username" id="username" tabindex="1" title="请输入用户名" autofocus="autofocus"
                        type="text" value="${(Parameters['username']?html)!}" style="width:105px;"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="password">密　码:&nbsp;</label>
                </td>
                <td>
                    <input id="password" name="password"  tabindex="2" type="password" style="width:105px;"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" name="submitBtn" tabindex="6" class="blue-button" value="登录"/>
                </td>
            </tr>
        </table>
        <table class="footage">
            <tr>
                <td style="text-align:right">
                </td>
            </tr>
        </table>
     </form>
</div>

<script type="text/javascript">
    var form  = document.loginForm;
    function checkLogin(form){
        if(!form['username'].value){
            alert("用户名称不能为空");return false;
        }
        if(!form['password'].value){
            alert("密码不能为空");return false;
        }
        return true;
    }
</script>
</body>
</html>
