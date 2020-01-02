[#ftl]
[#macro gaReportHead clazz squad]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName clazz.project.school!/]夜大学生考试签到表
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(clazz.semester.schoolYear)?if_exists}学年${(clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>教学点：${clazz.teachDepart.name}</td>
        <td>年级：${squad.grade}</td>
        <td>专业：${(squad.major.name)!}</td>
        <td>层次：${squad.level.name}</td>
        <td>课程名称：${clazz.course.name}</td>
      </tr>
    </table>
[/#macro]

[#macro gaReportFoot(clazz)]
[/#macro]

[#macro makeupReportHead clazz squad]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName clazz.project.school!/]夜大学生考试签到表
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(clazz.semester.schoolYear)?if_exists}学年${(clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>教学点：${clazz.teachDepart.name}</td>
        <td>年级：${squad.grade}</td>
        <td>专业：${(squad.major.name)!}</td>
        <td>层次：${squad.level.name}</td>
        <td>课程名称：${clazz.course.name}</td>
      </tr>
    </table>
[/#macro]

[#macro gaColumnTitle]
<tr align="center" class="columnTitle">
  [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
         <td width="23.7%">签名</td>
         [#if i ==1]
         <td class="columnSeparator"></td>
         [/#if]
  [/#list]
</tr>
[/#macro]

[#macro makeupColumnTitle]
<tr align="center" class="columnTitle">
  [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
         <td width="23.7%">签名</td>
         [#if i ==1]
         <td class="columnSeparator"></td>
         [/#if]
  [/#list]
</tr>
[/#macro]

[#macro makeupReportFoot (clazz)]
[/#macro]

[#macro displayGaTake(clazz,courseTakers, objectIndex,addSeparator)]
[#if  courseTakers[objectIndex]??]
    [#assign courseTaker =  courseTakers[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td>${courseTaker.std.user.name!}</td>

   [#if ((clazz.course.examMode.name)!"")?contains("考试")]

    [#if courseTaker.takeType.id=5][#--start考试课--]
      <td>免试</td>
    [#else]
     [#assign gaScore="&nbsp;"/]
      <td>
     [#list gradeTypes as gradeType]
      [#if gradeType.examType?? && examTakers.get(courseTaker.std)??]
        [#local et = examTakers.get(courseTaker.std)/]
        [#if et.examType==gradeType.examType && et.examStatus.id !=1 ]
        ${et.examStatus.name}[#assign gaScore][#if et.examStatus.deferred]●[#elseif et.examStatus.id=3]/[/#if][/#assign]
        [/#if]
      [#else]
        ${gaScore!}
      [/#if]
    [/#list]
      </td>
    [/#if][#--end考试课--]

   [#else][#--start考查课--]

    [#if courseTaker.takeType.id=5][#--start考查课--]
      <td>免试</td>
    [#else]

    [#list gradeTypes as gradeType]
      [#if gradeType.id==2]
     <td>
      [#if gradeType.examType?? && examTakers.get(courseTaker.std)??]
        [#local et = examTakers.get(courseTaker.std)/]
        [#if et.examType==gradeType.examType && et.examStatus.id !=1 ]
        ${et.examStatus.name}[#if et.examStatus.deferred]●[/#if]
        [/#if]
      [/#if]
     </td>
     [/#if]
     [/#list]
     [/#if][#--end考查课--]
   [/#if]

[#else]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td></td>
    <td></td>
    <td></td>
[/#if]
  [#if addSeparator]
    <td class="columnSeparator"></td>
  [/#if]
[/#macro]

[#macro displayMakeupTake(clazz,courseTakers, objectIndex,addSeparator)]
[#if  courseTakers[objectIndex]??]
    [#assign courseTaker =  courseTakers[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td>${courseTaker.std.user.name!}</td>
    <td></td>
[#else]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td></td>
    <td></td>
    <td></td>
[/#if]
  [#if addSeparator]
    <td class="columnSeparator"></td>
  [/#if]
[/#macro]

[#include "blankMacroExt.ftl"/]
