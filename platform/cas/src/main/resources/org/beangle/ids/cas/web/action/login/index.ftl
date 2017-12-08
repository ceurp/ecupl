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
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="${base}/static/css/login.css" />
  </head>
  <body>

<div class="logindiv">
    <div style="position : absolute;top : 15px;left : 20px;">
    <image style="width:532px;height:80px" src="${base}/static/images/banner1.jpg"/>
    </div>
    <div class="banner2"></div>
    <form name="loginForm" action="${base}/login" target="_top" method="post">
    [#if Parameters['sid_name']??]
      <input type="hidden" name="sid_name" value="${Parameters['sid_name']}">
    [/#if]
    [#if Parameters['service']??]
	  <input type="hidden" name="service" value="${Parameters['service']}">
	[#else]
	<input type="hidden" name="sid_name" value="URP_SID}">
	<input type="hidden" name="service" value="http://${request.serverName}:${request.serverPort}/openurp/index.action">
	[/#if]
        <table class="bulletin">
            <tr>
                <td>
                <image style="width:530px;height:230px" src="${base}/static/images/tu2.jpg"/>
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
                    <input name="username" id="username" tabindex="1" title="请输入用户名" type="text" value="${Parameters['username']!}" style="width:105px;"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="password">密　码:&nbsp;</label>
                </td>
                <td>
                    <input id="password" name="password"  tabindex="2" type="password" style="width:105px;"/>
                    <input name="encodedPassword" type="hidden" value=""/>
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
