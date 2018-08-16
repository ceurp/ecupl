
[#--header--]
[#macro head]
<!DOCTYPE html>
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  <title>华政继教教务系统门户</title>
  <link rel="stylesheet" type="text/css" href="${static_base}/platform/0.0.5/css/default.css">
  <link rel="stylesheet" type="text/css" id="theme2" href="${static_base}/platform/0.0.5/css/style-${theme}.css">
  [#nested/]
</head>
<body>
[/#macro]

[#--portal上的小panel--]
[#macro panel name cssClass]
<div class="${cssClass}">
  <table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tbody>
      <tr>
        <td>
          <table width="100%" cellspacing="0" cellpadding="0" border="0" class="PTableBack">
            <tbody>
              <tr>
                <td class="PTitleLeft"></td>
                <td valign="middle" align="left" class="PTitle"><nobr>${name}</nobr></td>
                <td nowrap="true" align="right"><img width="1" height="1" src="${static_base}/platform/0.0.5/images/blank.gif"></td>
                <td align="right" class="PTitleRight"></td>
              </tr>
            </tbody>
          </table>

          <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody>
              <tr>
                <td class="PContentLeft"></td>
                <td valign="top" align="left" class="PContent" colspan="2">
                [#nested/]
                </td>
                <td nowrap="true" style="font-size:1pt;" class="PContentRight">&nbsp;</td>
              </tr>
            </tbody>
          </table>

          <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody>
              <tr>
                <td class="PBottomLeft"></td>
                <td nowrap="true" style="font-size:1pt;" class="PBottom">&nbsp;</td>
                <td class="PBottomRight"></td>
              </tr>
            </tbody>
          </table>
        </td>
      </tr>
    </tbody>
  </table>
</div>
[/#macro]

[#macro foot]
<table width="1000px" style="margin:auto">
  <tbody>
    <tr>
      <td valign="bottom">
        <table width="100%" align="center" cellspacing="0px" cellpadding="0px" border="0">
          <tbody>
            <tr align="center">
              <td align="center" border="0" class=" ext-gecko ext-linux">
                <table width="1000" height="75"  border="0" align="center" cellpadding="0" cellspacing="0" class="fontsize_10_linehi19">
                  <tr>
                    <td>
                      <table width="100%" height="26px"  border="0" cellpadding="0" cellspacing="0" style="font-size:12px;line-height: 18pt;" align="center">
                        <tr>
                          <td valign="middle" height="20px">
                            <div align="center"> Copyright © 2015 All Rights Reserved 华政继教教务系统&nbsp;&nbsp;
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td valign="middle" height="20">
                            <div align="center">地址：上海市万航渡路1575号华东政法大学继续教育学院 电话：(021)62071806<br />
                            </div>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </tbody>
        </table>

      </td>
    </tr>
  </tbody>
</table>
[#nested/]
</body>
</html>
[/#macro]
