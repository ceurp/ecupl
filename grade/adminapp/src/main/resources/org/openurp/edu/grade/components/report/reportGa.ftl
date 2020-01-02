[#ftl]
[@b.head/]
[#include "/template/macros.ftl"/]
[#assign perRecordOfPage = 50/]
[#include "reportMacros.ftl"/]
[#include "reportStyle.ftl"/]
[@reportStyle/]
[@b.toolbar title="教学班总评成绩打印"]
   bar.addPrint();
   bar.addClose();
[/@]
[#list reports as report]
  [#if report.courseGradeState??]

    [#assign squadCourseGrades={}/]
    [#assign retakeCourseGrades=[]/]
    [#assign squadMap={}/]

    [#list report.courseGrades as ct]
      [#if ct.courseTakeType.id ==3]
        [#assign retakeCourseGrades=retakeCourseGrades+[ct]/]
      [#else]
        [#if !(squadCourseGrades[ct.std.squad.name])??]
          [#assign squadMap = squadMap+ {ct.std.squad.name:ct.std.squad}/]
          [#assign squadCourseGrades = squadCourseGrades+ {ct.std.squad.name:[]}/]
        [/#if]
        [#assign squadCourseGrades = squadCourseGrades + {ct.std.squad.name: squadCourseGrades[ct.std.squad.name]+[ct]} /]
      [/#if]
    [/#list]
    [#assign squads = squadCourseGrades?keys?sort/]
    [#list squads as squad]
       [#assign squadCourseGrades=squadCourseGrades+{squad:squadCourseGrades[squad]?sort_by(["std","user","code"])}/]
    [/#list]
    [#assign squadCourseGrades=squadCourseGrades+{squads?last:(squadCourseGrades[squads?last]+retakeCourseGrades?sort_by(["std","user","code"]))}/]

    [#list squads as squad]
        [#assign recordIndex = 0/]
        [#assign courseGrades=squadCourseGrades[squad]/]
        [#assign pageSize = ((courseGrades?size / perRecordOfPage)?int * perRecordOfPage == courseGrades?size)?string(courseGrades?size / perRecordOfPage, courseGrades?size / perRecordOfPage + 1)?number/]
        [#list (pageSize == 0)?string(0, 1)?number..pageSize as pageIndex]

        [@gaReportHead report squadMap[squad]/]
        <table align="center" class="reportBody" width="100%">
           [@reportColumnTitle report/]
           [#list 0..(perRecordOfPage / 2 - 1) as onePageRecordIndex]
           <tr>
            [@displayGaGrade report,courseGrades, recordIndex,true/]
            [@displayGaGrade report,courseGrades, recordIndex + perRecordOfPage / 2 ,false/]
            [#assign recordIndex = recordIndex + 1/]
           </tr>
           [/#list]
           [#assign recordIndex = perRecordOfPage * pageIndex/]
        </table>
        [@gaReportFoot report/]
            [#if (pageIndex + 1 < pageSize)]
        <div style="PAGE-BREAK-AFTER: always;"></div>
            [/#if]
        [/#list]
        [#if squad_has_next]
        <div style="PAGE-BREAK-AFTER: always;"></div>
        [/#if]
    [/#list]
    [#if report_has_next]
    <div style="PAGE-BREAK-AFTER: always"></div>
    [/#if]

 [#else]
      该课程没有学生成绩!
 [/#if]
[/#list]

[@b.foot/]
