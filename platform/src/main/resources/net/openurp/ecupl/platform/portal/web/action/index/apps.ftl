[@panel name="业务系统" cssClass="nju-3"]
<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0" class="fontsize_10_linehi12">
  <tbody>
    <tr>
      <td width="100%" valign="top">
        <table align="center" cellspacing="1" cellpadding="2" border="0" style="width: 275px; height: 91px">
          <tbody>
            <tr>
              <td height="5"></td>
              <td></td>
            </tr>
            [#list apps?chunk(2) as appRow]
            <tr height="23">
              [#list appRow as app]
              <td ><a target="_blank" href="${app.url?replace('{openurp.webapp}',webappBase)}"><img border="0" src="${static_base}/images/app/default.gif">${app.title}</a></td>
              [/#list]
            </tr>
            [/#list]
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
[/@panel]
