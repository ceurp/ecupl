[#ftl/]
[#macro reportStyle]
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
    height:36px;
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
[/#macro]
