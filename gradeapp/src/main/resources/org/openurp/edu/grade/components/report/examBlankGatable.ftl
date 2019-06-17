[#ftl]
[@b.head/]
[#include "/template/macros.ftl"/]
[#assign perRecordOfPage = 30/]
[#include "examBlankMacros.ftl"/]
[@reportStyle/]
[@b.toolbar title="教学班总评成绩登分表打印"]
  bar.addPrint();
  bar.addClose();
[/@]
[#list clazzes as clazz]
    [#assign courseGrades = courseGradeMap.get(clazz)/]
    [#assign examTakers = examTakerMap.get(clazz)/]
    [#assign courseGradeState = stateMap.get(clazz)/]

    [#assign squadCourseTakers={}/]
    [#assign retakeCourseTakers=[]/]

    [#assign allCourseTakers = courseTakerMap.get(clazz)?sort_by(["std","code"])/]
    [#list allCourseTakers as ct]
      [#if ct.takeType.id ==3]
        [#assign retakeCourseTakers=retakeCourseTakers+[ct]/]
      [#else]
        [#if !(squadCourseTakers[ct.std.squad.name])??]
          [#assign squadCourseTakers = squadCourseTakers+ {ct.std.squad.name:[]}/]
        [/#if]
        [#assign squadCourseTakers = squadCourseTakers + {ct.std.squad.name: squadCourseTakers[ct.std.squad.name]+[ct]} /]
      [/#if]
    [/#list]
    [#assign squads = squadCourseTakers?keys?sort/]
    [#list squads as squad]
       [#assign squadCourseTakers=squadCourseTakers+{squad:squadCourseTakers[squad]?sort_by(["std","user","code"])}/]
    [/#list]
    [#assign squadCourseTakers=squadCourseTakers+{squads?last:(squadCourseTakers[squads?last]+retakeCourseTakers?sort_by(["std","user","code"]))}/]
    [#list squads as squad]
        [#assign recordIndex = 0/]
        [#assign courseTakers=squadCourseTakers[squad]/]
        [#assign pageSize = ((courseTakers?size / perRecordOfPage)?int * perRecordOfPage == courseTakers?size)?string(courseTakers?size / perRecordOfPage, courseTakers?size / perRecordOfPage + 1)?number/]
        [#list (pageSize == 0)?string(0, 1)?number..pageSize as pageIndex]

        [@gaReportHead clazz squad/]
        <table align="center" class="reportBody" width="100%">
           [@gaColumnTitle/]
           [#list 0..perRecordOfPage-1 as onePageRecordIndex]
           <tr>
        [@displayGaTake courseTakers, recordIndex/]
            [#assign recordIndex = recordIndex + 1/]
           </tr>
           [/#list]
           [#assign recordIndex = perRecordOfPage * pageIndex/]
        </table>
        [@gaReportFoot clazz/]
            [#if (pageIndex + 1 < pageSize)]
        <div style="PAGE-BREAK-AFTER: always;"></div>
            [/#if]
        [/#list]
        [#if squad_has_next]
        <div style="PAGE-BREAK-AFTER: always;"></div>
        [/#if]
    [/#list]
    [#if clazz_has_next]
    <div style="PAGE-BREAK-AFTER: always"></div>
    [/#if]
[/#list]

[@b.foot/]
