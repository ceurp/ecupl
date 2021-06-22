[#ftl]
[#include "reportHeader.ftl"/]
[#include "/template/macros.ftl"/]
[#assign perRecordOfPage = 30/]
[#include "examBlankMacros.ftl"/]
[#include "examReportStyle.ftl"/]
[@reportStyle/]
[@b.toolbar title="教学班期末考试签到表打印"]
  bar.addPrint();
  bar.addClose();
[/@]
[#list clazzes as clazz]
    [#assign courseGrades = courseGradeMap.get(clazz)/]
    [#assign examTakers = examTakerMap.get(clazz)/]
    [#assign courseGradeState = stateMap.get(clazz)/]

    [#assign squadCourseTakers={}/]
    [#assign retakeCourseTakers=[]/]
    [#assign squadMap={}/]

    [#assign allCourseTakers = courseTakerMap.get(clazz)?sort_by(["std","code"])/]
    [#list allCourseTakers as ct]
      [#if ct.takeType.id ==3]
        [#assign retakeCourseTakers=retakeCourseTakers+[ct]/]
      [#else]
        [#if !(squadCourseTakers[ct.std.squad.name])??]
          [#assign squadMap = squadMap+ {ct.std.squad.name:ct.std.squad}/]
          [#assign squadCourseTakers = squadCourseTakers+ {ct.std.squad.name:[]}/]
        [/#if]
        [#assign squadCourseTakers = squadCourseTakers + {ct.std.squad.name: squadCourseTakers[ct.std.squad.name]+[ct]} /]
      [/#if]
    [/#list]
    [#assign squads = squadCourseTakers?keys?sort/]
    [#list squads as squad]
       [#assign squadCourseTakers=squadCourseTakers+{squad:squadCourseTakers[squad]?sort_by(["std","user","code"])}/]
    [/#list]
    [#if squads?size>0]
    [#assign squadCourseTakers=squadCourseTakers+{squads?last:(squadCourseTakers[squads?last]+retakeCourseTakers?sort_by(["std","user","code"]))}/]
    [/#if]
    [#list squads as squad]
        [#assign recordIndex = 0/]
        [#assign courseTakers=squadCourseTakers[squad]/]
        [#assign pageSize = ((courseTakers?size / perRecordOfPage)?int * perRecordOfPage == courseTakers?size)?string(courseTakers?size / perRecordOfPage, courseTakers?size / perRecordOfPage + 1)?number/]
        [#list (pageSize == 0)?string(0, 1)?number..pageSize as pageIndex]

        [@gaReportHead clazz squadMap[squad]/]
        <table align="center" class="reportBody" width="100%">
           [@gaColumnTitle/]
           [#list 0..(perRecordOfPage / 2 - 1) as onePageRecordIndex]
           <tr>
            [@displayGaTake clazz,courseTakers, recordIndex,true/]
            [@displayGaTake clazz,courseTakers, recordIndex + perRecordOfPage / 2 ,false/]
            [#assign recordIndex = recordIndex + 1/]
           </tr>
           [/#list]
           [#assign recordIndex = perRecordOfPage * pageIndex/]
        </table>
        <table width='100%' class="reportTitle" align='center'>
          <tr>
            <td>班级：${squad}</td>
          </tr>
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
