[#ftl]
[@b.head/]
<style>
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

 table.reportBody tr{
   height:7mm;
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
[#include "../clazzManagerCore/clazzFtlLib.ftl" /]

[@b.toolbar title='task.attendanceSheet']
   bar.addItem("[@msg.text name="action.print"/]","print()");
   bar.addClose("");
[/@]

[#list clazzes as clazz]
  [#assign units = clazz.schedule.lastWeek - clazz.schedule.firstWeek + 1 /]
  [#list pages[clazz.id?string] as page]
  <table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName clazz.project.school!/]课程点名册
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
    <table width="100%" border="0" class="reportBody">
       <tr align="center" class="columnTitle">
        <td width="3%">序号</td>
        <td width="11%">[@msg.text name="attr.stdNo"/]</td>
        <td width="7%">[@msg.text name="attr.personName"/]</td>
        <td width="4%">[@msg.text name="entity.gender"/]</td>
        <td width="5%"><span style="font-size:0.8em">修读类别</span></td>
      [#list 1..units as i]
        <td width="${70/units}%">${i}</td>
      [/#list]
      </tr>
      [#list page.takers as taker]
        <tr  align="center">
          <td>${page.startIndex+taker_index+1}</td>
          <td style="font-size: 10px;">${taker.std.user.code}</td>
          <td>${taker.std.user.name}[#if taskStdCollisionMap[clazz.id?string]?seq_contains(taker.std.id)]<font color="red">*</font>[/#if]</td>
          <td>[@i18nName taker.std.person.gender?if_exists/]</td>
          <td>[#assign takeTypeName]${(taker.takeType.name)!}[#if taker.freeListening]免听[/#if][#t/][/#assign]
          <span [#if takeTypeName?length>2]style="font-size:0.8em"[/#if]>${takeTypeName}</span>
          </td>
          [#list 1..units as i]
          <td>&nbsp;</td>
          [/#list]
        </tr>
      [/#list]
    </table>
    <table width="100%">
      <tr class="infoTitle">
      <td align="left">
        带<font color="red">*</font>号的学生与其他课程冲突。
        [@msg.text name="attendance.presence"/]&nbsp;&radic;&nbsp;&nbsp;
        [@msg.text name="attendance.absent"/]&nbsp;&chi;&nbsp;&nbsp;
        [@msg.text name="attendance.sickLeave"/]&nbsp;&Omicron;&nbsp;&nbsp;
        [@msg.text name="attendance.personalLeave"/]&nbsp;&Delta;&nbsp;&nbsp;
        [@msg.text name="attendance.beLateFor"/]&nbsp;&Phi;&nbsp;&nbsp;
      </td>
      <td align="right">[@msg.text name="teachTask.signature"/]：[#list 1..20 as j]&nbsp;[/#list][@msg.text name="common.toWriteDate"/]</td>
      </tr>
    </table>
    [#if page_has_next]<div style='page-break-after:always'></div>[/#if]
  [/#list]
  [#if clazz_has_next]<div style='page-break-after:always'></div>[/#if]
[/#list]

[@b.foot/]
