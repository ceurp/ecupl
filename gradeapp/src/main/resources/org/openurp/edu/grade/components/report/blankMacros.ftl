[#ftl]
[#macro gaReportHead clazz squad]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName clazz.project.school!/]夜大学生${(clazz.course.examMode.name)!}成绩登分表
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(clazz.semester.schoolYear)?if_exists}学年${(clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>层次：${squad.level.name}</td>
        <td>专业：${(squad.major.name)!}</td>
        <td>年级：${squad.grade}</td>
        <td>课程名称：${clazz.course.name}</td>
        <td style="text-align:right">任课教师：[#list clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
      </tr>
    </table>
[/#macro]

[#macro gaReportFoot(clazz)]
  <table align="center" class="reportFoot" width="100%">
    <tr>
      <td width="60%">[#--统计人数:${courseGrades?size}--]</td>
      <td width="40%">阅卷教师签名:</td>
    </tr>
    <tr>
      <td  colspan="2" style="text-align:right">______年____月____日</td>
    </tr>
  </table>
[/#macro]

[#macro gaColumnTitle clazz]
<tr align="center" class="columnTitle">
  [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
         [#if ((clazz.course.examMode.name)!"")?contains("考试")]
         [#list gradeTypes as gradeType]
            <td width="${23.7/gradeTypes?size}%">[#if gradeType.id=2]考试成绩[#elseif gradeType.id=7]总成绩[#else]${gradeType.name!}[/#if]</td>
         [/#list]
         [#else]<td width="23.7%">考查成绩</td>[/#if]
         [#if i ==1]
         <td class="columnSeparator"></td>
         [/#if]
  [/#list]
</tr>
[/#macro]

[#macro displayGaTake(clazz,courseTakers, objectIndex,addSeparator)]
[#if  courseTakers[objectIndex]??]
    [#assign courseTaker =  courseTakers[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td>${courseTaker.std.user.name!}</td>

   [#if ((clazz.course.examMode.name)!"")?contains("考试")]

    [#if courseTaker.takeType.id=5][#--start考试课--]
      [#if gradeTypes?size>1]
       [#list 1..gradeTypes?size-1 as i]
         <td></td>
       [/#list]
      [/#if]
      <td>免试</td>
    [#else]
     [#list gradeTypes as gradeType]
      <td>
      [#if gradeType.examType?? && examTakers.get(courseTaker.std)??]
        [#local et = examTakers.get(courseTaker.std)/]
        [#if et.examType==gradeType.examType && et.examStatus.id !=1 ]
        ${et.examStatus.name}
        [/#if]
      [/#if]
      </td>
    [/#list]
    [/#if][#--end考试课--]

   [#else][#--start考查课--]

    [#if courseTaker.takeType.id=5][#--start考查课--]
      <td></td>
      <td>免试</td>
    [#else]

    [#list gradeTypes as gradeType]
      [#if gradeType.id==2]
     <td>
        [#if gradeType.examType?? && examTakers.get(courseTaker.std)??]
        [#local et = examTakers.get(courseTaker.std)/]
        [#if et.examType==gradeType.examType && et.examStatus.id !=1 ]
        ${et.examStatus.name}
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
    [#if ((clazz.course.examMode.name)!"")?contains("考试")]
    [#list gradeTypes as gradeType]
    <td></td>
    [/#list]
    [#else]
    <td></td>
    [/#if]
[/#if]
  [#if addSeparator]
    <td class="columnSeparator"></td>
  [/#if]

[/#macro]

[#macro makeupReportHead clazz squad]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName clazz.project.school!/]夜大学生${(clazz.course.examMode.name)!}成绩登分表（补）
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(clazz.semester.schoolYear)?if_exists}学年${(clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>层次：${squad.level.name}</td>
        <td>专业：${(squad.major.name)!}</td>
        <td>年级：${squad.grade}</td>
        <td>课程名称：${clazz.course.name}</td>
        <td style="text-align:right">任课教师：[#list clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
      </tr>
    </table>
[/#macro]

[#macro makeupColumnTitle clazz]
<tr align="center" class="columnTitle">
  [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
    [#if ((clazz.course.examMode.name)!"")?contains("考试")]
         <td width="7.9%">平时成绩</td>
         <td width="7.9%">考试成绩</td>
    [#else]
         <td width="15.8%">考试成绩</td>
    [/#if]
         <td width="7.9%">总成绩</td>
         [#if i ==1]
         <td class="columnSeparator"></td>
         [/#if]
  [/#list]
</tr>
[/#macro]

[#macro makeupReportFoot (clazz)]
  <table align="center" class="reportFoot" width="100%">
    <tr>
      <td width="60%">[#--统计人数:${courseGrades?size}--]</td>
      <td width="40%">阅卷教师签名:</td>
    </tr>
    <tr>
      <td  colspan="2" style="text-align:right">______年____月____日</td>
    </tr>
  </table>
[/#macro]

[#macro displayMakeupTake(clazz,courseTakers, objectIndex,addSeparator)]

[#if  courseTakers[objectIndex]??]
     [#assign courseTaker = courseTakers[objectIndex]/]
     [#local cg =courseGrades.get(courseTaker.std)]
     [#local et =examTakers.get(courseTaker.std)]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td>${courseTaker.std.user.name!}</td>

   [#if ((clazz.course.examMode.name)!"")?contains("考试")]
     <td>
     [#if et.examType.name?index_of('缓')> -1]
    ${(courseGrades.get(courseTaker.std).getScoreText(USUAL))!}
    [#else]
    --
    [/#if]
    </td>
    <td>
     [#list gradeTypes as gradeType]
      [#if gradeType.examType?? && examTakers.get(courseTaker.std)??]
        [#local et = examTakers.get(courseTaker.std)/]
        [#if et.examType==gradeType.examType && et.examStatus.id !=1 ]
        ${et.examStatus.name}
        [/#if]
      [/#if]
    [/#list]
    </td>
   [#else][#--start考查课--]
     <td>
     [#list gradeTypes as gradeType]
      [#if gradeType.examType?? && examTakers.get(courseTaker.std)??]
        [#local et = examTakers.get(courseTaker.std)/]
        [#if et.examType==gradeType.examType && et.examStatus.id !=1 ]
        ${et.examStatus.name}
        [/#if]
      [/#if]
    [/#list]
    </td>
   [/#if][#--end考查课--]
   <td></td>
[#else]
    <td class="columnIndex"></td>
    [#if ((clazz.course.examMode.name)!"")?contains("考试")]
     [#list 1..5 as i]<td></td>[/#list]
    [#else]
    [#list 1..4 as i]<td></td>[/#list]
    [/#if]
[/#if]

  [#if addSeparator]
    <td class="columnSeparator"></td>
  [/#if]
[/#macro]

[#include "blankMacroExt.ftl"/]
