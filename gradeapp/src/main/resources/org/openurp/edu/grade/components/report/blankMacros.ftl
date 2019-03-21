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
<table align="center" style="text-align:center" cellpadding="0" cellspacing="0">
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
            [#list gradeTypes as gradeType][#if gradeType.id!=GA.id]&nbsp;${(gradeType.name)!}(__％)[/#if][/#list]
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

[#macro makeupReportHead clazz]
<table align="center" style="text-align:center" cellpadding="0" cellspacing="0">
        <tr>
            <td style="font-weight:bold;font-size:14pt" height="30px">
            [@i18nName clazz.project.school!/](${clazz.semester.schoolYear}学年${clazz.semester.name}学期)
            ${b.text('grade.makeupdelay')}登记表
             </td>
        </tr>
    </table>
    <table width='95%' class="reportTitle" align='center'>
        <tr>
            <td width="30%">课程名称:[@i18nName clazz.course!/]</td>
            <td width="25%">${b.text("attr.courseNo")}:${clazz.course.code}</td>
            <td width="20%">${b.text("attr.taskNo")}:${clazz.crn}</td>
            <td width="15%">教师:[#list clazz.teachers as t]${t.name}&nbsp;[/#list]</td>
        </tr>
        <tr>
            <td>班级名称:
            [#assign len = (clazz.name)?length/]
            [#assign teachclassName = clazz.name!/]
            [#assign max = 14/]
            [#assign teachclassName = clazz.name!/]
            [#if len>max]
                ${teachclassName?substring(0,max)}...
            [#else]
              ${teachclassName}
            [/#if]
            </td>
            <td>${b.text("common.courseType")}:[@i18nName clazz.courseType!/]</td>
            <td>考核方式:[@i18nName clazz.examMode!/]</td>
            <td align="left">人数:${(courseTakerMap.get(clazz)?size)!0}</td>
        </tr>
        <tr>
          <td align="left">院系:[@i18nName clazz.teachDepart!/]</td>
          <td colspan="3"></td>
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
         [#list 1..2 as i]
         <td class="columnIndexTitle" width="5%">${b.text("attr.index")}</td>
         <td width="15%">${b.text("attr.stdNo")}</td>
         <td width="10%">${b.text("attr.personName")}</td>
         <td width="10%">成绩类型</td>
         <td width="10%">成绩</td>
         [/#list]
       </tr>
[/#macro]

[#macro makeupReportFoot (clazz)]
    <table align="center" class="reportFoot" width="95%">
      <tr>
      <td width="20%">统计人数:${courseTakerMap.get(clazz)?size}</td>
      <td width="20%"></td>
      <td width="30%">教师签名:</td>
      <td width="30%">成绩录入日期:____年__月__日</td>
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
    [#list gradeTypes as gradeType]<td></td>[/#list]
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
    <td class="columnIndex">${objectIndex + 1}</td>
    <td>${courseTaker.std.user.code!}</td>
    <td>${courseTaker.std.user.name!}[#if courseTaker.takeType?exists && courseTaker.takeType.id != 1]<sup>${courseTaker.takeType.name}</sup>[/#if]</td>
    <td>${stdExamTakerMap[courseTaker.clazz.id?string+"_"+courseTaker.std.id?string].examType.name}</td>
    <td></td>
[#else]
    <td class="columnIndex"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
[/#if]
[/#macro]

[#include "blankMacroExt.ftl"/]
