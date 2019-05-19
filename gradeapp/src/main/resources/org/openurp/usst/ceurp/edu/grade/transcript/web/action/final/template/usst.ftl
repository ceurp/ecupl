[#ftl]
[#include "/template/macros.ftl"/]
[#macro displayFinal grade]
  [#if grade.courseTakeType.id=5]
  免试
  [#else]
    [#if grade.gaGrades?size=0]${grade.scoreText!"/"}[#else]
      [#--查找缓考总评和缓考考试情况--]
      [#assign findDelayGa=false/]
      [#list grade.gaGrades as ga]
        [#if ga.gradeType.id=8]
          [#assign findDelayGa=true/]
          [#if ga.scoreText??]${ga.scoreText}[#else]
            [#assign findDelayExam=false/]
            [#list grade.examGrades as eg]
              [#if eg.gradeType.id=6]
               [#assign findDelayExam=true/]
               [#if eg.examStatus.id !=1]${eg.examStatus.name}[#else]/[/#if]
               [#break/]
              [/#if]
            [/#list]
            [#if !findDelayExam]/[/#if]
          [/#if]
          [#break/]
        [/#if]
      [/#list]

    [#--如果没有缓考，查找期末总评和期末考试情况--]
    [#if !findDelayGa]
      [#list grade.gaGrades as ga]
        [#if ga.gradeType.id=7]
          [#if ga.scoreText??]${ga.scoreText}[#else]
            [#assign findFinalExam=false/]
            [#list grade.examGrades as eg]
              [#if eg.gradeType.id=2]
               [#assign findFinalExam=true/]
               [#if eg.examStatus.id !=1]${eg.examStatus.name}[#else]/[/#if]
               [#break/]
              [/#if]
            [/#list]
            [#if !findFinalExam]/[/#if]
          [/#if]
          [#break/]
        [/#if]
      [/#list]
    [/#if]
   [/#if][#--存在至少一个总评--]
  [/#if][#--不是免修--]
[/#macro]

[#macro displayMakeup grade]
  [#assign finded=false/]
     [#list grade.gaGrades as ga]
       [#if ga.gradeType.id=9]
        [#assign findMakeupExam=false/]
        [#if ga.scoreText??]${ga.scoreText}[#else]
            [#list grade.examGrades as eg]
              [#if eg.gradeType.id=4]
               [#assign findMakeupExam=true/]
               [#if eg.examStatus.id !=1]${eg.examStatus.name}[#else]/[/#if]
               [#break/]
              [/#if]
            [/#list]
            [#if !findMakeupExam]/[/#if]
        [/#if]
        [#assign finded=true/][#break/]
       [/#if]
     [/#list]
     [#if !finded]/[/#if]
[/#macro]

<style>
  .gradeTable {
    font-size:9pt;
    border-collapse:collapse;
    width:100%;
    font-family: 宋体;
   }
  .gradeTable td { border: solid #000 1px; text-align:center}
  .gradeHead {
    font-family: 宋体;
    width:100%;
    font-size:11pt;
   }
   .gradeFoot{
    font-family: 宋体;
    width:100%;
    font-size:11pt;
   }
</style>
[#list students as std]
<h2 style="text-align:center;font-family:楷体_GB2312;font-size:22pt">华东政法大学继续教育学院</h2>
<h2 style="text-align:center;font-family:宋体;font-size:26pt;font-weight: bold;margin-top: 0px;">学生学习成绩表</h2>

[#assign stdGrades = grades.get(std)?sort_by(["semester","beginOn"])]
<table align="center" class="gradeHead">
   <tr>
     <td width="35%">学习形式：${std.studyType.name} <div style="float:right">学历层次：${std.level.name}<div></td>
     <td width="15%" style="text-align:center">学制:${std.duration}</td>
     <td width="20%" style="text-align:center">${b.text('entity.major')}:[@i18nName std.major!/]</td>
     <td width="30%" style="text-align:center">年级：${std.grade}</td>
   </tr>
   <tr>
     <td>${b.text('attr.stdNo')}:${std.user.code!} <div style="float:right">${b.text('attr.personName')}:[@i18nName std!/]<div></td>
     <td style="text-align:center">${b.text('attr.gender')}:[@i18nName std.person.gender! /]</td>
     <td style="text-align:center">${b.text('grade.creditTotal')}:${(gpas.get(std).credits)!}</td>
     <td style="text-align:center">平均成绩（除英语外）:${(gpas.get(std).ga)!}</td>
   </tr>
</table>

<table class="gradeTable" align="center">
    <tr align="center">
      [#list 1..2 as i]
           <td width="20%">${b.text('课程名称')}</td>
           <td width="5%" align="center">获得学分</td>
           <td width="5%">正考成绩</td>
           <td width="5%">补考成绩</td>
           <td width="15%">学期</td>
      [/#list]
    </tr>

[#assign _pageSize=stdGrades?size/]
[#if _pageSize%2==1][#assign _pageSize=_pageSize+1/][/#if]
    [#list 0..(_pageSize/2-1) as i]
  <tr>
    [#if stdGrades[2*i]??]
    [#assign courseGrade = stdGrades[2*i] /]
    <td>[@i18nName courseGrade.course! /]</td>
    <td>[#if courseGrade.passed]${courseGrade.course.credits!}[#else]0[/#if]</td>
    <td>[@displayFinal  courseGrade/]</td>
    <td>[@displayMakeup courseGrade/]</td>
    <td>${courseGrade.semester.schoolYear!}学年${courseGrade.semester.name!}学期</td>
    [#else]
    <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    [/#if]

    [#if stdGrades[2*i+1]??]
    [#assign courseGrade = stdGrades[2*i+1] /]
    <td>[@i18nName courseGrade.course! /]</td>
    <td>[#if courseGrade.passed]${courseGrade.course.credits!}[#else]0[/#if]</td>
    <td>[@displayFinal  courseGrade/]</td>
    <td>[@displayMakeup courseGrade/]</td>
    <td>${courseGrade.semester.schoolYear!}学年${courseGrade.semester.name!}学期</td>
    [#else]
    <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    [/#if]
  </tr>
    [/#list]
</table>

[@b.div style="margin-top:5px;"/]

<table align="center" class="gradeFoot">
    <tr><td colspan="4">&nbsp;</td></tr>
    <tr>
      <td style="text-align:right">${(b.now?string('yyyy年MM月dd日'))!}</td>
   </tr>
</table>
<div style="PAGE-BREAK-AFTER: always"></div>
[/#list]
