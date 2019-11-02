[#ftl]

[#macro gaReportHead report squad]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            华东政法大学夜大学生${(report.clazz.course.examMode.name)!}成绩登分表
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(report.clazz.semester.schoolYear)?if_exists}学年${(report.clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>层次：${squad.level.name}</td>
        <td>专业：${(squad.major.name)!}</td>
        <td>年级：${squad.grade}</td>
        <td>课程名称：${report.clazz.course.name}</td>
        <td style="text-align:right">任课教师：[#list report.clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
      </tr>
    </table>
[/#macro]

[#macro gaReportFoot report]
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

[#macro makeupReportHead report squad]
<table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
            [@i18nName report.clazz.project.school!/]夜大学生${(report.clazz.course.examMode.name)!}成绩登分表
             <td>
        </tr>
        <tr>
          <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(report.clazz.semester.schoolYear)?if_exists}学年${(report.clazz.semester.name)?if_exists?replace("0","第")}学期）</td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
      <tr>
        <td>层次：${squad.level.name}</td>
        <td>专业：${(squad.major.name)!}</td>
        <td>年级：${squad.grade}</td>
        <td>课程名称：${report.clazz.course.name}</td>
      </tr>
    </table>
[/#macro]

[#macro reportColumnTitle report]
<tr align="center" class="columnTitle">
  [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
         [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]
         <td width="7.9%">平时成绩</td>
         [#list report.gradeTypes as gradeType]
            [#if gradeType.id!=3]
            <td width="${7.9}%">[#if gradeType.id=2]考试成绩[#elseif gradeType.id=7]总成绩[#else]${gradeType.name!}[/#if]</td>
            [/#if]
         [/#list]
         [#else]<td width="23.7%">考查成绩</td>[/#if]
         [#if i ==1]
         <td class="columnSeparator"></td>
         [/#if]
  [/#list]
</tr>
[/#macro]

[#macro displayGaGrade(report,courseGrades, objectIndex ,addSeparator)]
[#if  courseGrades[objectIndex]??]
    [#assign courseGrade =  courseGrades[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseGrade.std.user.code!}</td>
    <td>${courseGrade.std.user.name!}</td>

   [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]

    [#if courseGrade.courseTakeType.id=5]
      <td>--</td>
      <td>--</td>
      <td>免试</td>
    [#else]
     <td>
     [#assign displayUsual=false/]
     [#list report.gradeTypes as gradeType]
      [#if gradeType.id==3]
        [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
        [#if examGrade!="null"]
          [#assign displayUsual=true/]
          [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!'--')?length>2]<span class="longScoreText">${examGrade.scoreText!'--'}</span>[#else]${examGrade.scoreText!'--'}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
        [/#if]
      [/#if]
     [/#list]
     [#if !displayUsual]--[/#if]
     </td>

     [#list report.gradeTypes as gradeType]
     [#if gradeType.id!=3]
     <td>
        [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
        [#if examGrade!="null"]
          [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!)?length>2]<span class="longScoreText">${examGrade.scoreText!}</span>[#else]${examGrade.scoreText!}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
        [/#if]
     </td>
     [/#if]
     [/#list]
    [/#if]

   [#else]
    [#--start考查课--]
    [#if courseGrade.courseTakeType.id=5]
      <td>免试</td>
    [#else]

    [#list report.gradeTypes as gradeType]
      [#if gradeType.id==2]
     <td>
        [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
        [#if examGrade!="null"]
          [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!)?length>2]<span class="longScoreText">${examGrade.scoreText!}</span>[#else]${examGrade.scoreText!}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
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
    [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]
    <td></td><td></td><td></td>
    [#else]
    <td></td>
    [/#if]
[/#if]
  [#if addSeparator]
    <td class="columnSeparator"></td>
  [/#if]
[/#macro]

[#macro makeupReportColumnTitle report]
<tr align="center" class="columnTitle">
         [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
          [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]
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

[#macro makeupReportFoot report]
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

[#macro displayMakeupGrade(report,courseGrades, objectIndex ,addSeparator)]
[#if courseGrades[objectIndex]??]
    [#assign courseGrade = courseGrades[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseGrade.std.user.code!}</td>
    <td>${courseGrade.std.user.name!}</td>


    [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]
     <td>
      [#assign displayUsual=false/]
      [#assign usualScore="--"/]
      [#list courseGrade.examGrades as eg]
        [#if eg.gradeType.id==3]
          [#assign usualScore]${eg.scoreText!}[/#assign]
        [#elseif eg.gradeType.id==6]
          [#assign displayUsual=true/]
        [/#if]
      [/#list]
    [#if displayUsual]${usualScore!'--'}[#else]--[/#if]
    </td>
    <td>
      [#list report.gradeTypes as gradeType]
      [#if !gradeType.ga && gradeType.id!=FINAL.id]
      [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
      [#if examGrade!="null"]
        [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!)?length>2]<span class="longScoreText">${examGrade.scoreText!}</span>[#else]${examGrade.scoreText!}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
      [/#if]
      [/#if]
     [/#list]
    </td>
   [#else][#--start考查课--]
     <td>
     [#list report.gradeTypes as gradeType]
      [#if !gradeType.ga && gradeType.id!=FINAL.id]
      [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
      [#if examGrade!="null"]
        [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!)?length>2]<span class="longScoreText">${examGrade.scoreText!}</span>[#else]${examGrade.scoreText!}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
      [/#if]
      [/#if]
     [/#list]
    </td>
   [/#if][#--end考查课--]
   <td>
     [#list courseGrade.gaGrades as ga]
        [#if ga.gradeType.id!=GA.id]
          ${ga.scoreText!}
        [/#if]
      [/#list]
   </td>
[#else]
    <td class="columnIndex"></td>
    [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]
     [#list 1..5 as i]<td></td>[/#list]
    [#else]
    [#list 1..4 as i]<td></td>[/#list]
    [/#if]
[/#if]
  [#if addSeparator]
    <td class="columnSeparator"></td>
  [/#if]
[/#macro]

[#include "reportMacroExt.ftl"/]
