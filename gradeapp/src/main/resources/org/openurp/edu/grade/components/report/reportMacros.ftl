[#ftl]
[#macro reportStyle]
<style type="text/css">
.reportBody {
    border:solid;
    border-color:#006CB2;
    border-collapse: collapse;
    border-width:2px;
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
    border-width:0 1px 1px 0;
}

table.reportBody td.columnIndex{
    border-width:0 1px 1px 2px;
}

table.reportBody tr{
  height:20pt;
}
table.reportTitle {
  margin-top:20px;
}
table.reportTitle tr{
  border-width:1px;
  font-size:11pt;
  font-weight:bold;
  font-family:黑体
}
tr.columnTitle td{
  border-width:1px 1px 2px 1px;
  word-break: break-all;
  white-space:pre-wrap;
  font-size:9pt;
  font-family:黑体
}

tr.columnTitle td.columnIndexTitle{
  border-width:1px 1px 2px 2px;
}

table.reportFoot{
  font-size:12pt;
  font-family:黑体
  margin-bottom:20px;
}

table.reportFoot tr {
  height:45px;
}
.examStatus{
  
}
.longScoreText{
  font-size:10px;
}
</style>
[/#macro]

[#macro gaReportHead report squad]
<table align="center" style="text-align:center" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:23pt;font-family:宋体" height="30px">
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

[#macro makeupReportHead report]
<table align="center" style="text-align:center" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:14pt" height="30px">
            [@i18nName report.clazz.project.school!/](${(report.clazz.semester.schoolYear)?if_exists}学年${(report.clazz.semester.name)?if_exists?replace("0","第")}学期)
            补(缓)考成绩登记表
             <td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
        <tr>
          <td width="30%">课程名称:[@i18nName report.clazz.course!/]</td>
            <td width="25%">${b.text("attr.courseNo")}:${report.clazz.course.code}</td>
            <td width="20%">${b.text("common.courseType")}:[@i18nName report.clazz.courseType!/]</td>
            <td width="15%">教师:[#list report.clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
        </tr>
        <tr>
            <td>班级名称:
            [#assign len = (report.clazz.name)?length/]
            [#assign squadName = report.clazz.name!/]
            [#assign max = 28/]
            [#if len>max]
              [#list 0..(len/max-1) as i]
                ${squadName?substring(i*max,i*max+max)}<br>
              [/#list]
              [#if (len%max !=0)]
                ${squadName?substring(len-(len%max),len)}
              [/#if]
            [#else]
              ${squadName}
            [/#if]
            </td>
            <td>${b.text("attr.taskNo")}:${report.clazz.crn}</td>
            <td>考核方式:[@i18nName report.clazz.examMode!/]</td>
            <td align="left">人数:${(report.courseGrades?size)!0}</td>
        </tr>
        <tr>
          <td align="left">院系:[@i18nName report.clazz.enrollment.depart!/]</td>
          <td colspan="3"></td>
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
         [#list report.gradeTypes as gradeType]
            <td width="${23.7/report.gradeTypes?size}%">${gradeType.name!}</td>
         [/#list]
         [#else]<td width="23.7%">考查成绩</td>[/#if]
  [/#list]
</tr>
[/#macro]

[#macro makeupReportColumnTitle report]
<tr align="center" class="columnTitle">
         [#list 1..2 as i]
         <td class="columnIndexTitle" width="4.4%">${b.text("attr.index")}</td>
         <td width="14%">${b.text("attr.stdNo")}</td>
         <td width="7.9%">${b.text("attr.personName")}</td>
         [#list report.gradeTypes as gradeType]
            [#if !gradeType.ga && gradeType.id!=FINAL.id]
            <td width="${23.7/(report.gradeTypes?size)}%">${gradeType.name!}</td>
            [/#if]
         [/#list]
         <td width="${23.7/(report.gradeTypes?size)}%">总评/最终</td>
         [/#list]
       </tr>
[/#macro]
[#macro makeupReportFoot report]
    <table align="center" class="reportFoot" width="100%">
      <tr>
      <td width="20%">统计人数:${report.courseGrades?size}</td>
      <td width="20%"></td>
      <td width="30%">教师签名:</td>
      <td width="30%">${(report.courseGradeState.updatedAt?string('yyyy-MM-dd'))!}</td>
    </tr>
  </table>
[/#macro]

[#macro displayGaGrade(report,courseGrades, objectIndex)]
[#if  courseGrades[objectIndex]??]
    [#assign courseGrade =  courseGrades[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseGrade.std.user.code!}</td>
    <td>${courseGrade.std.user.name!}[#if courseGrade.courseTakeType?exists && courseGrade.courseTakeType.id != 1]<sup>${courseGrade.courseTakeType.name}</sup>[/#if]</td>

   [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]

    [#if courseGrade.courseTakeType.id=5]
      [#if report.gradeTypes?size>1]
       [#list 1..report.gradeTypes?size-1 as i]
         <td></td>
       [/#list]
      [/#if]
      <td>免试</td>
    [#else]
     [#list report.gradeTypes as gradeType]
     <td>
        [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
        [#if examGrade!="null"]
          [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!)?length>2]<span class="longScoreText">${examGrade.scoreText!}</span>[#else]${examGrade.scoreText!}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
        [/#if]
     </td>
     [/#list]
    [/#if]
    
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
   [/#if]
         

[#else]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td></td>
    <td></td>
     [#if ((report.clazz.course.examMode.name)!"")?contains("考试")]
    [#list report.gradeTypes as gradeType]
    <td></td>
    [/#list]
    [#else]
    <td></td>
    [/#if]
[/#if]
[/#macro]

[#macro displayMakeupGrade(report, objectIndex)]
[#if report.courseGrades[objectIndex]??]
    [#assign courseGrade = report.courseGrades[objectIndex]/]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td style="font-size:11px">${courseGrade.std.user.code!}</td>
    <td style="font-size:11px">${courseGrade.std.user.name!}[#if courseGrade.courseTakeType?exists && courseGrade.courseTakeType.id != 1]<span style="font-size: 5.5pt; top: -4px; position: relative">${courseGrade.courseTakeType.name}</span>[/#if]</td>
    [#list report.gradeTypes as gradeType]
    [#if !gradeType.ga && gradeType.id!=FINAL.id]
      <td>
      [#local examGrade=courseGrade.getGrade(gradeType)!"null"/]
      [#if examGrade!="null"]
      [#if !examGrade.gradingMode.numerical && (examGrade.scoreText!)?length>2]<span class="longScoreText">${examGrade.scoreText!}</span>[#else]${examGrade.scoreText!}[/#if][#if examGrade.examStatus?? && examGrade.examStatus.id!=1]<span class="examStatus"> ${examGrade.examStatus.name}</span>[/#if]
      [/#if]
      </td>
    [/#if]
     [/#list]
     <td>
     [#list courseGrade.gaGrades as ga]
        [#if ga.gradeType.id!=GA.id]
          ${ga.scoreText!}
        [/#if]
      [/#list]
     </td>
[#else]
    <td class="columnIndex"></td>
    <td></td>
    <td></td>
    [#list report.gradeTypes as gradeType]
      [#if !gradeType.ga]
    <td></td>
      [/#if]
    [/#list]
    <td></td>
[/#if]
[/#macro]

[#include "reportMacroExt.ftl"/]
