[#ftl]
﻿[@b.head/]
[@b.toolbar title='学生名单']
   bar.addItem("[@msg.text name="action.print"/]","print()");
   bar.addItem("[@msg.text name="action.export"/]","export2Excel()");
   bar.addClose("");
   function export2Excel(){
      bg.form.submit(document.clazzForm);
   }
[/@]
[#include '../clazzManagerCore/clazzFtlLib.ftl'/]
<style type="text/css">
.reportBody {
    border-collapse: collapse;
    vertical-align: middle;
    font-style: normal;
    font-size: 9pt;
    font-family:宋体;
    table-layout: fixed;
    text-align:center;
    white-space: nowrap;
}
table.reportBody td{
    border-style:solid;
    border-color:#006CB2;
    border-width:1px 1px;
}

table.reportBody td.columnIndex{
    border-width:0 1px 1px 1px;
}

table.reportBody td.columnSeparator{
  border-width:0 0px 0px 0;
  width:0.5%;
}

table.reportBody tr{
  height:22pt;
}
table.reportTitle {
  margin-top:10px;
}
table.reportTitle tr{
  border-width:1px;
  font-size:11pt;
  font-weight:bold;
  font-family:黑体
}
tr.columnTitle td{
  border-width:1px 1px 1px 1px;
  word-break: break-all;
  white-space:pre-wrap;
  font-size:9pt;
  font-family:黑体
}

table.reportFoot{
  font-size:12pt;
  font-family:黑体
}

table.reportFoot tr {
  height:40px;
}
.examStatus{

}
.longScoreText{
  font-size:10px;
}
</style>
[@b.form name="clazzForm"  action="!printStdList"]
  [#list Parameters?keys as k]
  <input type="hidden" name="${k}" value="${Parameters[k]}"/>
  [/#list]
  <input type="hidden" name="excel" value="1">
  <input type="hidden" name="template" value="template/excel/clazzStdListSquad.xlsx">
[/@]
[#list clazzes! as clazz]
    [#list pages[clazz.id?string] as page]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName clazz.project.school!/]夜大学生名册
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(clazz.semester.schoolYear)?if_exists}学年${(clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
<table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>层次：${page.squad.level.name}</td>
        <td>专业：${(page.squad.major.name)!}</td>
        <td>年级：${page.squad.grade}</td>
        <td>课程名称：${clazz.course.name}</td>
        <td style="text-align:right">任课教师：[#list clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
      </tr>
    </table>

      <table class="reportBody"  width="100%">
        <tr  class="columnTitle" align="center">
          <td width="5%" class="columnIndexTitle">序号</td>
          <td width="16%">[@msg.text name="attr.stdNo"/]</td>
          <td width="12%">[@msg.text name="attr.personName"/]</td>
          <td width="7%">修读类别</td>
          <td width="10%">备注</td>
          <td class="columnSeparator"></td>
          <td width="5%" class="columnIndexTitle">序号</td>
          <td width="16%">[@msg.text name="attr.stdNo"/]</td>
          <td width="12%">[@msg.text name="attr.personName"/]</td>
          <td width="7%">修读类别</td>
          <td width="9%">备注</td>
        </tr>
      [#list 0..(page.pageSize/2-1) as i]
        [#assign row=page.getRow(i,2)/]
        <tr style="text-align:center">
        [#if row[0]??]
          <td class="columnIndex">${row[0]}</td>
          <td>${row[1].std.user.code}</td>
          <td>[@i18nName row[1].std/]</td>
          <td>${row[1].takeType.name}</td>
        [#else]
          <td>&nbsp;</td><td>&nbsp;</td>
          <td>&nbsp;</td><td>&nbsp;</td>
        [/#if]
          <td></td>
          <td class="columnSeparator"></td>
        [#if row[2]?? ]
          <td class="columnIndex">${row[2]}</td>
          <td>${row[3].std.user.code}</td>
          <td>[@i18nName  row[3].std/]</td>
          <td>${row[3].takeType.name}</td>
        [#else]
          <td>&nbsp;</td><td>&nbsp;</td>
          <td>&nbsp;</td><td>&nbsp;</td>
        [/#if]
          <td></td>
        </tr>
      [/#list]
      </table>
      [#if page_has_next]<div style='page-break-after: always'></div>[/#if]
    [/#list]
    [#if clazz_has_next]<div style='page-break-after: always'></div>[/#if]
[/#list]

[@b.foot/]
