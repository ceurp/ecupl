[#ftl]
[#if !(request.getHeader('x-requested-with')??) && !Parameters['x-requested-with']??]
<!DOCTYPE html>
<html lang="zh_CN">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta http-equiv="content-style-type" content="text/css"/>
    <meta http-equiv="content-script-type" content="text/javascript"/>
  ${b.script("requirejs","require.js")}
  ${b.script("jquery","jquery.min.js")}
  ${b.script("bui","js/jquery-history.js")}
  ${b.script("bui","js/beangle.js")}
  ${b.script("bui","js/beangle-ui.js")}
  ${b.css("bui","css/beangle-ui.css")}
  <script type="text/javascript">
    beangle.register("${b.static_base()}/",{
        "beangle":{js:"bui/0.3.0/js/beangle.js"},
        "bui":{js:"bui/0.3.0/js/beangle-ui.js",css:["bui/0.3.0/css/beangle-ui.css"]}
    });
   beangle.getContextPath=function(){
      return "${base}";
   }
   var App = {contextPath:'${base}'}
  </script>
  [@include_if_exists path="head_ext.ftl"/]
 </head>
 <body style="font-size:13px">
[/#if]
