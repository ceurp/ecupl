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
    font-size: 14px;
    font-family:宋体;
    table-layout: fixed;
    text-align:center;
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
  height:25px;
}

table.reportTitle tr{
  height:25px;
  border-width:1px;
  font-size:13px;
}
tr.columnTitle td{
  border-width:1px 1px 2px 1px;
}

tr.columnTitle td.columnIndexTitle{
  border-width:1px 1px 2px 2px;
  font-size:12px;
}

table.reportFoot{
  margin-bottom:20px;
}
table.reportFoot.tr {
}
.examStatus{
  font-size:10px;
}
.longScoreText{
  font-size:10px;
}
</style>
[/#macro]

[#macro gaReportHead clazz squad]
<table align="center" style="text-align:center;margin-top:7px" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:14pt" height="30px">
            [@i18nName clazz.project.school!/](${clazz.semester.schoolYear}学年${clazz.semester.name}学期)
            总评成绩登记表
             </td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center' >
        <tr>
            <td width="33%">课程名称:[@i18nName clazz.course!/]</td>
            <td width="25%">${b.text("attr.courseNo")}:${clazz.course.code}</td>
            <td width="20%">${b.text("common.courseType")}:[@i18nName clazz.courseType!/]</td>
            <td width="12%">教师:[#list clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
        </tr>
        <tr>
            <td>班级名称:
            [#assign len = (squad)?length/]
            [#assign teachclassName = (squad)!/]
            [#assign max = 14/]
            [#if len>max]
                ${teachclassName?substring(0,max)}...
            [#else]
              ${teachclassName}
            [/#if]
            </td>
            <td>${b.text("attr.taskNo")}:${clazz.crn}</td>
            <td>考核方式:[@i18nName clazz.examMode!/]</td>
            <td align="left">人数:${courseTakers?size}</td>
        </tr>
        <tr>
          <td align="left">院系:[@i18nName clazz.enrollment.depart!/]</td>
          <td colspan="3">成绩类型:
            [#list gradeTypes as gradeType][#if gradeType.id!=GA.id]&nbsp;${(gradeType.name)!}(${courseGradeState.getPercent(gradeType)!('___')}％)[/#if][/#list]
          </td>
        </tr>
    </table>
[/#macro]

[#macro gaReportFoot(clazz)]
  <table align="center" class="reportFoot" width="100%" style="height: 30px;">
      <tr>
      <td width="20%">统计人数:${courseTakers?size}</td>
      <td width="40%">教师签名:</td>
      <td width="40%">成绩录入日期:______年____月____日</td>
     </tr>
  </table>
[/#macro]

[#macro makeupReportHead clazz squad]
<table align="center" style="text-align:center;margin-top:7px" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:14pt" height="30px">
            [@i18nName clazz.project.school!/](${clazz.semester.schoolYear}学年${clazz.semester.name}学期)
            ${b.text('grade.makeupdelay')}登记表
             </td>
        </tr>
    </table>
    <table width='100%' class="reportTitle" align='center'>
        <tr>
            <td width="30%">课程名称:[@i18nName clazz.course!/]</td>
            <td width="25%">${b.text("attr.courseNo")}:${clazz.course.code}</td>
            <td width="20%">${b.text("attr.taskNo")}:${clazz.crn}</td>
            <td width="15%">教师:[#list clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
        </tr>
        <tr>
            <td>班级名称:
            [#assign len = (squad)?length/]
            [#assign teachclassName = (squad)!/]
            [#assign max = 14/]
            [#if len>max]
                ${teachclassName?substring(0,max)}...
            [#else]
              ${teachclassName}
            [/#if]
            </td>
            <td>${b.text("common.courseType")}:[@i18nName clazz.courseType!/]</td>
            <td>考核方式:[@i18nName clazz.examMode!/]</td>
            <td align="left">人数:${(courseTakers?size)!0}</td>
        </tr>
        <tr>
          <td align="left">院系:[@i18nName clazz.teachDepart!/]</td>
          <td colspan="2">百分比:
          平时${(courseGradeState.getPercent(USUAL)!('___'))!}％,考试${(courseGradeState.getPercent(END)!('___'))!}％
          </td>
          <td></td>
        </tr>
    </table>
[/#macro]

[#macro gaColumnTitle]
<tr align="center" class="columnTitle">
 <td class="columnIndexTitle" width="6%">${b.text("attr.index")}</td>
 <td width="18%">${b.text("attr.stdNo")}</td>
 <td width="10%">${b.text("attr.personName")}</td>
 <td width="11%">学生签名</td>
 <td width="9%">修读类别</td>
 [#list gradeTypes as gradeType]<td width="${36/gradeTypes?size}%">${gradeType.name}</td>[/#list]
 <td width="10%">备注</td>
</tr>
[/#macro]

[#macro makeupColumnTitle]
<tr align="center" class="columnTitle">
 <td class="columnIndexTitle" width="6%">${b.text("attr.index")}</td>
 <td width="17%">${b.text("attr.stdNo")}</td>
 <td width="10%">${b.text("attr.personName")}</td>
 <td width="11%">学生签名</td>
 <td width="9%">修读类别</td>
 <td width="7%">平时</td>
 <td width="7%">考试</td>
 <td width="7%">总评</td>
 <td width="26%">备注</td>
</tr>
[/#macro]

[#macro makeupReportFoot (clazz)]
    <table align="center" class="reportFoot" width="100%" style="height: 30px;">
      <tr>
      <td width="20%">统计人数:${courseTakers?size}</td>
      <td width="40%">教师签名:</td>
      <td width="40%">成绩录入日期:______年____月____日</td>
    </tr>
  </table>
[/#macro]

[#macro displayGaTake(courseTakers, objectIndex)]
[#if courseTakers[objectIndex]??]
    [#assign courseTaker = courseTakers[objectIndex] /]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td style="font-size:13px">${courseTaker.std.user.name!}</td>
    <td></td>
    <td>${courseTaker.takeType.name}</td>
    [#if courseTaker.takeType.id==5]
    <td colspan="3">[#if courseGrades.get(courseTaker.std)??]${courseGrades.get(courseTaker.std).remark!}[/#if]</td>
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
    [/#if]
    <td></td>
[#else]
    <td class="columnIndex"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    [#list gradeTypes as gradeType]
    <td></td>
    [/#list]
    <td></td>
[/#if]
[/#macro]

[#macro displayMakeupTake(courseTakers, objectIndex)]
[#if courseTakers[objectIndex]??]
    [#assign courseTaker = courseTakers[objectIndex]/]
     [#local cg =courseGrades.get(courseTaker.std)]
     [#local et =examTakers.get(courseTaker.std)]
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td>${courseTaker.std.user.name!}</td>
    <td></td>
    <td>${courseTaker.takeType.name}</td>
    <td>
    [#if et.examType.name?index_of('缓')> -1]
    ${(courseGrades.get(courseTaker.std).getScoreText(USUAL))!}
    [#else]
    --
    [/#if]
    </td>
    <td></td>
    <td></td>
    <td style="font-size:0.8em">
     [#if et.examType.name?index_of('缓')> -1]
            初考缓考(平时分：${(courseGrades.get(courseTaker.std).getScoreText(USUAL))!})[#t]
     [#else]
     [#if ((cg.getExamGrade(END).examStatus.id)!0) != 1]
             初考${(cg.getExamGrade(END).examStatus.name)!}[#t]
     [#else]
      初考不及格[#t]
     [/#if],无平时分最高60[#t]
     [/#if]
    </td>
[#else]
    <td class="columnIndex"></td>
    [#list 1..8 as i]<td></td>[/#list]
[/#if]
[/#macro]

[#include "blankMacroExt.ftl"/]
