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
      [#if ga.status==2]
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
      [#else]
      /
      [/#if]
    [/#if]
  [/#list]

  [#if !findDelayGa]
     [#assign finded=false/]
     [#list grade.gaGrades as ga]
       [#if ga.gradeType.id=9]
        [#assign finded=true/]
        [#if ga.status==2]
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
        [#break/]
        [#else]/[/#if] [#--end status=2--]
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
<table align="center" class="${isGQB?string("gqb_GradeHead","zsb_GradeHead")}" style="margin-bottom:2px">
   <tr>
     <td width="33%">${b.text('attr.stdNo')}:${std.user.code!}</td>
     <td width="33%">${b.text('attr.personName')}:[@i18nName std!/]</td>
     <td width="34%">${b.text('attr.gender')}:[@i18nName std.person.gender! /]</td>
   </tr>
   <tr>
     <td>学习形式：${std.studyType.name}</td>
     <td>学历层次：${std.level.name}</td>
     <td>${b.text('entity.major')}:[@i18nName std.major!/]</td>
   </tr>
</table>

<table class="${isGQB?string("gqb_GradeTable","zsb_GradeTable")} [#if scale_min]${isGQB?string("gqbmin_GradeTable","zsbmin_GradeTable")}[/#if]" align="center">
    <tr align="center" class="reportTitle">
      [#list 1..2 as i]
           <td width="8.5%">学期</td>
           <td width="5%">序号</td>
           <td width="21%">${b.text('课程名称')}</td>
           <td width="5%" align="center">学分</td>
           <td width="5%" class="exam_mode_caption" ><img src="data:image/png;base64,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" width="100%" height="100%"/></td>
           <td width="5%">补考</td>
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
