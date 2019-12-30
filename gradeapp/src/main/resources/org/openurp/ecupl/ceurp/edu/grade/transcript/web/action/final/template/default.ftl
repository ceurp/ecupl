[#ftl]
[#include "/template/macros.ftl"/]
[#macro displayFinal grade]
  [#if grade.courseTakeType.id=5]
  免试
  [#else]
    [#if grade.gaGrades?size=0]${grade.scoreText!"/"}[#else]
      [#--查找期末总评和期末考试情况--]
      [#list grade.gaGrades as ga]
        [#if ga.gradeType.id=7]
          [#if ga.scoreText?? && ga.scoreText?length>0]${ga.scoreText}[#else]
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
   [/#if][#--存在至少一个总评--]
  [/#if][#--不是免修--]
[/#macro]

[#macro displayMakeup grade]
  [#--查找缓考总评和缓考考试情况--]
  [#assign findDelayGa=false/]
  [#list grade.gaGrades as ga]
    [#if ga.gradeType.id=8]
      [#assign findDelayGa=true/]
      [#if ga.scoreText?? && ga.scoreText?length>0]${ga.scoreText}[#else]
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

  [#if !findDelayGa]
     [#assign finded=false/]
     [#list grade.gaGrades as ga]
       [#if ga.gradeType.id=9]
        [#if ga.scoreText?? && ga.scoreText?length>0]${ga.scoreText}[#else]
            [#assign findMakeupExam=false/]
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
  [/#if]
[/#macro]

<style>
   .reportTitle{
      border-width:1px;
      font-size:9pt;
      font-weight:bold;
      font-family:黑体
   }
   .gradeFoot{
    font-family: 宋体;
    width:100%;
    font-size:10pt;
   }
   .reportHead{
     text-align:center;font-family:宋体;font-size:23pt;margin-top:0px;
   }
  .zsb_GradeTable {
    font-size:9pt;
    border-collapse:collapse;
    width:100%;
    font-family: 宋体;
   }
  .zsb_GradeTable td { border: solid #000 1px; text-align:center}
  .zsb_GradeHead {
    font-family: 黑体;
    width:100%;
    font-size:10pt;
   }
   table.zsb_GradeTable td.columnSeparator{
      border-width:0 0px 0px 0;
      width:1%;
    }
   table.zsb_GradeHead tr{
     height:25px;
   }
   table.zsb_GradeTable tr{
     height:10mm;
   }

   table.zsbmin_GradeTable tr{
     height:8.5mm;
   }
   .gqb_GradeTable {
       font-size:9pt;
       border-collapse:collapse;
       width:100%;
       font-family: 宋体;
    }
   .gqb_GradeTable td { border: solid #000 1px; text-align:center}
   .gqb_GradeHead {
       font-family: 黑体;
       width:100%;
       font-size:10pt;
    }
    table.gqb_GradeTable td.columnSeparator{
         border-width:0 0px 0px 0;
         width:1%;
    }
    table.gqb_GradeHead tr{
      height:20px;
    }
    table.gqb_GradeTable tr{
      height:10mm;
    }
    table.gqbmin_GradeTable tr{
      height:8mm;
    }
</style>
[#list students as std]
[#assign isGQB = (std.level.name == '高起本')]
<h2 class="reportHead">华东政法大学夜大学生成绩表</h2>

[#function buildSemesterCode courseGrade]
  [#if courseGrade.courseTakeType.id=3 || courseGrade.crn?? && courseGrade.crn?starts_with("BK")]
   [#return "r"+courseGrade.semester.code/]
  [#else]
   [#return "n"+courseGrade.semester.code/]
  [/#if]
[/#function]

[#assign semesters={}]
[#assign stdGradesMap={}]
[#list grades.get(std) as cg]
  [#if !(semesters[cg.semester.code]??)]
   [#assign semesters=semesters+{cg.semester.code:cg.semester}]
  [/#if]
  [#assign thisSemesterCode=buildSemesterCode(cg)/]
  [#assign stdGradesMap=stdGradesMap+{thisSemesterCode:((stdGradesMap[thisSemesterCode])![])+[cg]}]
[/#list]

[#assign stdGradeIndice = {}]
[#assign stdGrades = []]
[#list stdGradesMap?keys?sort as semesterCode]
  [#assign thisSemesterGrades=stdGradesMap[semesterCode]?sort_by(["course","name"])/]
  [#if semesterCode?starts_with('n')]
    [#list thisSemesterGrades as g]
    [#assign stdGradeIndice = stdGradeIndice+{g.id?string:stdGradeIndice?size+1}]
    [/#list]
  [/#if]
  [#assign stdGrades =stdGrades+thisSemesterGrades/]
  [#assign stdGradesMap=stdGradesMap+{semesterCode:thisSemesterGrades}]
[/#list]

[#assign totalSize=stdGrades?size/]
[#assign semesterCodes = stdGradesMap?keys?sort/]
[#assign _pageSize=0/]
[#assign maxSemesterPerColumn=4]
[#if isGQB]
  [#assign maxSemesterPerColumn=5] [#--高起本左侧多打一个学期--]
[/#if]

[#list semesterCodes as semesterCode]
  [#assign _pageSize = _pageSize + stdGradesMap[semesterCode]?size/]
  [#if semesterCode_index + 2 > maxSemesterPerColumn] [#-- 最多显示maxSemesterPerColumn个学期 --]
    [#break/]
  [/#if]
[/#list]
[#if _pageSize *2 < totalSize]
    [#assign newStdGrades= stdGrades[0.._pageSize-1]]
    [#list 1 .. totalSize - 2*_pageSize as i]
        [#assign newStdGrades = newStdGrades + ["null"]]
    [/#list]
    [#assign newStdGrades =newStdGrades + stdGrades[_pageSize..totalSize-1]]
    [#assign stdGrades = newStdGrades]
    [#assign _pageSize = totalSize - _pageSize/]
[/#if ]

[#if isGQB]
   [#assign scale_min = _pageSize > 25]
[#else]
   [#assign scale_min = _pageSize > 20]
[/#if]
[#assign printedSemesterCodes=[]/]
<table align="center" class="${isGQB?string("gqb_GradeHead","zsb_GradeHead")}">
   <tr>
     <td width="20%">学习形式：${std.studyType.name}</td>
     <td width="19.5%">学历层次：${std.level.name}</td>
     <td width="20%">${b.text('entity.major')}:[@i18nName std.major!/]</td>
     <td width="14%">学制:${std.duration}</td>
     <td width="27.5%">年级：${std.grade}</td>
   </tr>
   <tr>
     <td>${b.text('attr.stdNo')}:${std.user.code!}</td>
     <td>${b.text('attr.personName')}:[@i18nName std!/]</td>
     <td>${b.text('attr.gender')}:[@i18nName std.person.gender! /]</td>
     <td>${b.text('grade.creditTotal')}:${(gpas.get(std).credits)!}</td>
     <td>平均成绩（除英语外）:${(gpas.get(std).ga)!}</td>
   </tr>
</table>

<table class="${isGQB?string("gqb_GradeTable","zsb_GradeTable")} [#if scale_min]${isGQB?string("gqbmin_GradeTable","zsbmin_GradeTable")}[/#if]" align="center">
    <tr align="center" class="reportTitle">
      [#list 1..2 as i]
           <td width="8.5%">学期</td>
           <td width="5%">序号</td>
           <td width="21%">${b.text('课程名称')}</td>
           <td width="5%" align="center">学分</td>
           <td width="5%">考试成绩</td>
           <td width="5%">补考成绩</td>
           [#if i ==1]
           <td class="columnSeparator"></td>
           [/#if]
      [/#list]
    </tr>
    [#if _pageSize>0]
    [#list 0.._pageSize-1 as i]
  <tr>
    [#if stdGrades[i]?? && (stdGrades[i]?is_hash)]
    [#assign courseGrade = stdGrades[i] /]

    [#assign semesterCode=buildSemesterCode(courseGrade)]
    [#if !printedSemesterCodes?seq_contains(semesterCode)]
     [#assign printedSemesterCodes=printedSemesterCodes+[semesterCode]/]
     <td rowspan="${stdGradesMap[semesterCode]?size}">${courseGrade.semester.schoolYear!}学年<br>${courseGrade.semester.name!}学期</td>
    [/#if]
    <td>${stdGradeIndice[courseGrade.id?string]!}</td>
    <td>[@i18nName courseGrade.course!/]</td>
    <td>[#if stdGradeIndice[courseGrade.id?string]??]${courseGrade.course.credits!}[#else]/[/#if]</td>
    <td>[@displayFinal  courseGrade/]</td>
    <td>[@displayMakeup courseGrade/]</td>
    [#else]
    <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    <td>&nbsp;</td><td>/</td><td>/</td>
    [/#if]

    <td class="columnSeparator"></td>
    [#if stdGrades[_pageSize+i]??]
    [#assign courseGrade = stdGrades[_pageSize+i] /]
    [#assign semesterCode=buildSemesterCode(courseGrade)]
    [#if !printedSemesterCodes?seq_contains(semesterCode)]
     [#assign printedSemesterCodes=printedSemesterCodes+[semesterCode]/]
     <td rowspan="${stdGradesMap[semesterCode]?size}">${courseGrade.semester.schoolYear!}学年<br>${courseGrade.semester.name!}学期</td>
    [/#if]
    <td>${stdGradeIndice[courseGrade.id?string]!}</td>
    <td>[@i18nName courseGrade.course! /]</td>
    <td>[#if stdGradeIndice[courseGrade.id?string]??]${courseGrade.course.credits!}[#else]/[/#if]</td>
    <td>[@displayFinal  courseGrade/]</td>
    <td>[@displayMakeup courseGrade/]</td>
    [#else]
    <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
    [/#if]
  </tr>
    [/#list]
    [/#if][#-- _pageSize > 0 --]
</table>
<div style="PAGE-BREAK-AFTER: always"></div>
[/#list]
