[#ftl]
[#include "/template/macros.ftl"/]
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/course/grade/gradeSeg.js"></script>
[@b.form name="gradeListForm" action="!search" target="contentDiv"]
<input name="_params" value="${b.paramstring}" type="hidden"/>
[@b.grid items=clazzes var="clazz" filterable="true"]
  [@b.gridbar]
      bar.addItem("查看", "info(document.gradeListForm)");
  [#if (Parameters["status"]!"0") != "0"]
    bar.addItem("${gradeType.name}打印", "printTeachClassGrade(document.gradeListForm, '${gradeType.id}')");
    printMenu=bar.addMenu("试卷分析", "printExamReport(document.gradeListForm)");
    printMenu.addItem("打印分段统计", "printStatReport(document.gradeListForm, 'task')");
    printMenu.addItem("课程分段统计", "printStatReport(document.gradeListForm, 'course')");
    printMenu.addItem("打印空白登分表","printBlankRegistrationForm(document.gradeListForm)");
    printMenu.addItem("打印考场签到表","printBlankExamForm(document.gradeListForm)");
    [#if  (Parameters["status"]!"0") == "1"]
    bar.addItem("发布${gradeType.name}", "publishCancelGrade(document.gradeListForm, ${gradeType.id}, true)");
    [#else]
    [@ems.guard res="/course/manage"]
    bar.addItem("取消发布${gradeType.name}", "publishCancelGrade(document.gradeListForm, ${gradeType.id}, false)");
    [/@]
    [/#if]
  [#else]
    bar.addItem("录入/百分比", "inputTask()", "new.png", "录入成绩/调整百分比，只能是单个任务的操作");
    bar.addItem("打印空白登分表","printBlankRegistrationForm(document.gradeListForm)");
    bar.addItem("打印考场签到表","printBlankExamForm(document.gradeListForm)");
    bar.addItem("删除${gradeType.name}", "removeGrade(${gradeType.id},'${gradeType.name}', '确定要删除该教学任务下的所有${gradeType.name}成绩吗？')");
  [/#if]
  [/@]
    [@b.gridfilter property="teachers[0].name"]
      <input name="teacher.user.name" type="text" style="width:95%;" value="${(Parameters['teacher.user.name'])!}" maxlength="100" />
  [/@]
  [@b.row]
    [@b.boxcol/]
    [@b.col property="crn" title="attr.taskNo" width="10%"/]
    [@b.col property="course.code" title="attr.courseNo" width="10%"/]
    [@b.col property="course.name" title="attr.courseName" width="22%"/]
    [@b.col property="name" title="entity.teachclass" width="35%"/]
    [@b.col width="10%" property="teachers[0].name" title="entity.teacher" sortable="false"][@getTeacherNames clazz.teachers/][/@]
    [@b.col  title="attr.stdNum" width="5%" property="enrollment.actual"]
      [@b.a href='/teachTaskCollege!printAttendanceCheckList?clazzIds=${clazz.id}' title='查看点名册' target='_blank']${clazz.enrollment.actual}[/@]
    [/@]
    [@b.col property="course.credits" title="attr.credit" width="5%"/]
    [@b.col property="course.creditHours" title="课时" width="5%"/]
  [/@]
[/@]
[/@]
<script language="JavaScript">
    jQuery(function(){
    bg.form.addHiddens(document.gradeListForm, "${b.paramstring}");
  });
  //打印教学班成绩
  function printTeachClassGrade(form, gradeTypeIds){
        if (null != gradeTypeIds && "" != gradeTypeIds) {
           if (null == form["gradeTypeIds"]) {
             bg.form.addInput(form, "gradeTypeIds", gradeTypeIds, "hidden");
           } else {
             form["gradeTypeIds"].value = gradeTypeIds;
           }
        } else {
           if (null != form["gradeTypeIds"]) {
             form["gradeTypeIds"].value = "";
           }
        }
        var clazzIds = bg.input.getCheckBoxValues("clazz.id");
        if (null == clazzIds || "" == clazzIds) {
            alert("请选择要操作的记录。");
            return;
        }
        bg.form.addInput(form,"clazzIds",clazzIds);
        bg.form.submit(form,"${b.url('!report')}","_blank");
  }

  function publishCancelGrade(form, gradeTypeId, isPublished) {
    var clazzIds = bg.input.getCheckBoxValues("clazz.id");
        if (null == clazzIds || "" == clazzIds) {
            alert("请选择要操作的记录。");
            return;
        }
        if (confirm(isPublished ? "确定要发布" + (null == gradeTypeId ? "所有" : "当前指定的") + "成绩吗？" : "确定要取消发布吗？")) {
            bg.form.addInput(form, "isPublished", isPublished, "hidden");
            if (null != gradeTypeId) {
                bg.form.addInput(form, "gradeTypeId", gradeTypeId, "hidden");
            }
            bg.form.addInput(form,"status","${status!}");
            bg.form.addInput(form, "clazzIds", clazzIds, "hidden");
            bg.form.addInput(form, "refer", "${action.class.name}", "hidden");
            if(isPublished){
              bg.form.submit(form,"${b.url('publish!publish')}");
            }else{
              bg.form.submit(form,"${b.url('manage!revoke')}");
            }
        }
  }

  //录入成绩欢迎界面
  function inputTask(){
    var form = document.gradeListForm;
         var clazzId = bg.input.getCheckBoxValues("clazz.id");
         if(isEmpty(clazzId) || clazzId.indexOf(",")>0){
            alert("请仅选择一个教学任务.");
            return false;
         }
         bg.form.addInput(form,"clazzId",clazzId);
         [#if validateToken??]
           bg.form.addInput(form,"validateToken","${validateToken}");
         [/#if]
         bg.form.submit(form,"${b.url('/course/input!inputTask')}","_blank");
   }

    //删除考试成绩
  function removeGrade(gradeTypeId, gradeTypeName, additionalMsg){
    var form = document.gradeListForm;
    var clazzId = bg.input.getCheckBoxValues("clazz.id");
    if(isEmpty(clazzId) || clazzId.indexOf(",")>0){
      alert("请仅选择一个教学任务.");
      return;
    }
    bg.form.addInput(form,"status","${status!}");
         bg.form.addInput(form,"gradeTypeId",gradeTypeId);
         bg.form.addInput(form,"clazzId",clazzId);
         if(!confirm(autoLineFeed(isEmpty(additionalMsg) ?"删除" + gradeTypeName + "的同时会将其状态置为“未录入”，\n要继续吗？" : additionalMsg)))return;
         bg.form.submit(form,"${b.url('!removeGrade')}");
  }

  function editGradeState(form){
    var clazzId = bg.input.getCheckBoxValues("clazz.id");
    if(isEmpty(clazzId) || clazzId.indexOf(",")>0){
      alert("请仅选择一个教学任务.");
          return;
    }
         bg.form.addInput(form,"clazzId",clazzId);
         bg.form.addInput(form,"status","${status}");
       bg.form.submit(form,"${b.url('college!editGradeState')}");
   }

   //查看成绩信息
   function info(form){
     var clazzId = bg.input.getCheckBoxValues("clazz.id");
    if(isEmpty(clazzId) || clazzId.indexOf(",")>0){
      alert("请仅选择一条要操作的记录.");
          return;
    }
         bg.form.addInput(form,"clazzId",clazzId);
         bg.form.addInput(form,"gradeTypeIds","");
         bg.form.addInput(form,"statusGradeTypeId","${gradeType.id}");
       bg.form.submit(form,"${b.url('!info')}?orderBy=std.user.code asc");
   }

    //打印分段统计
   function printStatReport(form,kind){
      form.action="${b.url('!stat')}";
      for(var i=0;i<seg.length;i++){
          var segAttr="segStat.scoreSegments["+i+"]";
          bg.form.addInput(form,segAttr+".min",seg[i].min);
          bg.form.addInput(form,segAttr+".max",seg[i].max);
        }
        if(null==kind){
           kind="task";
        }
        bg.form.addInput(form,"kind",kind);
        bg.form.addInput(form,"scoreSegmentsLength",seg.length);
        form.target="_blank";
        bg.form.submitId(form,"clazz.id",true);
        form.target="contentDiv";
   }
     //打印试卷分析
     function printExamReport(form){
        form.target="_blank";
        form.action="${b.url('input!reportForExam')}";
      for(var i=0;i<seg.length;i++){
          var segAttr="segStat.scoreSegments["+i+"]";
          bg.form.addInput(form,segAttr+".min",seg[i].min);
          bg.form.addInput(form,segAttr+".max",seg[i].max);
        }
        bg.form.addInput(form,"scoreSegmentsLength",seg.length);
        bg.form.submitId(form,"clazz.id",true);
        form.target="contentDiv";
        form.action = "${b.url('college!search')}";
     }

      //成绩登记表打印
     function printBlankRegistrationForm(form){
        form.target="_blank";
        bg.form.submitId(form,"clazz.id",true,"${b.url('report!blank')}?gradeType.id=${gradeType.id}");
        form.target="contentDiv"
     }
     //考场签名表
     function printBlankExamForm(form){
        form.target="_blank";
        bg.form.submitId(form,"clazz.id",true,"${b.url('report!blank')}?gradeType.id=${gradeType.id}&exam=1");
        form.target="contentDiv"
     }
</script>
