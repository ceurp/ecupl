[#ftl]
[@b.head/]
[@b.toolbar title="毕业补考成绩打印"]
   bar.addPrint();
   bar.addClose();
[/@]
<style type="text/css">
.reportBody {
    border-collapse: collapse;
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
    border-width:1px 1px;
}

table.reportBody td.columnIndex{
    border-width:0 1px 1px 1px;
}

table.reportBody td.columnSeparator{
  border-width:0 0px 0px 0;
  width:0.5%;
}

table.reportBody tr{
  height:22pt;
}
table.reportTitle {
  margin-top:10px;
}
table.reportTitle tr{
  border-width:1px;
  font-size:11pt;
  font-weight:bold;
  font-family:黑体
}
tr.columnTitle td{
  border-width:1px 1px 1px 1px;
  word-break: break-all;
  white-space:pre-wrap;
  font-size:9pt;
  font-family:黑体
}

table.reportFoot{
  font-size:12pt;
  font-family:黑体
}

table.reportFoot tr {
  height:40px;
}
.examStatus{

}
.longScoreText{
  font-size:10px;
}
</style>
[#macro emptyTd count]
     [#list 1..count as i]
     <td></td>
     [/#list]
[/#macro]
[#macro displayScore grade]
  [#if ((grade.getExamGrade(MAKEUP).examStatus.id)!0)!=1]
  ${grade.getExamGrade(MAKEUP).examStatus.name}
  [#else]
  ${grade.getScoreText(MAKEUP_GA)!}
  [/#if]
[/#macro]
[#assign pagePrintRow = 25 /]
   [#list makeupCourses  as task]
    [#assign grades=gradeMap.get(task)?sort_by(['std','user','code'])]
   [#assign pageNos=(grades?size/(pagePrintRow*2))?int /]
   [#if ((grades?size)>(pageNos*(pagePrintRow*2)))]
   [#assign pageNos=pageNos+1 /]
   [/#if]
   [#list 0..pageNos-1 as pageNo]
   [#assign passNo=pageNo*pagePrintRow*2 /]
     <table align="center" style="text-align:center;margin-top: 15px;" cellpadding="0" cellspacing="0">
         <tr>
             <td style="font-weight:bold;font-size:22pt;font-family:宋体" height="30px">
             华东政法大学夜大学生成绩登分表
              <td>
         </tr>
         <tr>
           <td style="font-weight:bold;font-size:14pt;font-family:宋体" >（${(task.semester.schoolYear)?if_exists}学年${(task.semester.name)?if_exists?replace("0","第")}学期）</td>
         </tr>
     </table>
     <table width='100%' class="reportTitle" align='center'>
       <tr>
         <td>层次：[#list task.squads as squad]${squad.level.name}[/#list]</td>
         <td>专业：[#list task.squads as squad]${(squad.major.name)!}[/#list]</td>
         <td>年级：[#list task.squads as squad]${squad.grade}[/#list]</td>
         <td>课程名称：${task.course.name}</td>
       </tr>
   </table>
   <table class="reportBody"  width="100%"  >
     <tr  height="29px" align="center">
       <td width="5%">序号</td>
       <td width="15%">学号</td>
       <td width="9%">姓名</td>
       <td width="20%">考试成绩</td>
       <td class="columnSeparator"></td>
       <td width="5%">序号</td>
       <td width="15%">学号</td>
       <td width="9%">姓名</td>
       <td width="20%" >考试成绩</td>
     </TR>
     [#list 0..pagePrintRow-1 as i]
     <tr class="brightStyle"  >
     [#if grades[i+passNo]?exists]
       <td>${i+1+passNo}</td>
       <td>${grades[i+passNo].std.user.code}</td>
       <td>${grades[i+passNo].std.user.name}</td>
       <td>
         [@displayScore grades[i+passNo]/]
       </td>
       <td class="columnSeparator"></td>
       [#if grades[i+pagePrintRow+passNo]?exists]
       <td>${i+pagePrintRow+1+passNo}</td>
       <td>${grades[i+pagePrintRow+passNo].std.user.code}</td>
       <td>${grades[i+pagePrintRow+passNo].std.user.name}</td>
       <td>[@displayScore grades[i+pagePrintRow+passNo]/]</td>
       [#else]
          [@emptyTd count=4/]
       [/#if]
     [#else]
        [@emptyTd count=4/]
        <td class="columnSeparator"></td>
        [@emptyTd count=4/]
     [/#if]
     </tr>
     [/#list]
     </table>
  <table align="center" class="reportFoot" width="100%">
    <tr>
      <td width="60%">[#--统计人数:${courseGrades?size}--]</td>
      <td width="40%">阅卷教师签名:</td>
    </tr>
    <tr>
      <td  colspan="2" style="text-align:right">______年____月____日</td>
    </tr>
  </table>
     [#if pageNo_has_next]<div style='PAGE-BREAK-AFTER: always'></div>[/#if]
     [/#list]
    [#if task_has_next]<div style='PAGE-BREAK-AFTER: always'></div>[/#if]
   [/#list]
[@b.foot/]
