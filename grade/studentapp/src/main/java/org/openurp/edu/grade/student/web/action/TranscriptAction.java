/*
 * OpenURP, Agile University Resource Planning Solution.
 *
 * Copyright © 2014, The OpenURP Software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful.
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.openurp.edu.grade.student.web.action;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.beangle.commons.collection.CollectUtils;
import org.beangle.commons.dao.query.builder.OqlBuilder;
import org.beangle.commons.entity.metadata.Model;
import org.beangle.commons.lang.Strings;
import org.beangle.security.Securities;
import org.openurp.code.edu.model.CourseTakeType;
import org.openurp.code.edu.model.GradeType;
import org.openurp.edu.base.model.Project;
import org.openurp.edu.base.model.Student;
import org.openurp.edu.grade.app.model.ReportTemplate;
import org.openurp.edu.grade.app.service.ReportTemplateService;

import org.openurp.edu.grade.transcript.service.TranscriptDataProvider;
import org.openurp.edu.grade.transcript.service.impl.SpringTranscriptDataProviderRegistry;
import org.openurp.std.info.model.Graduation;
import org.openurp.edu.web.action.BaseAction;

import com.google.gson.Gson;

/**
 * 学生打印自己的成绩单总表
 */
public class TranscriptAction extends BaseAction {

  private ReportTemplateService reportTemplateService;

  private SpringTranscriptDataProviderRegistry dataProviderRegistry;

  private Student getLoginStudent() {
    OqlBuilder<Student> stdQuery = OqlBuilder.from(Student.class, "std");
    stdQuery.where("std.user.code = :usercode", Securities.getUsername());
    List<Student> stds = entityDao.search(stdQuery);

    if (stds.isEmpty()) {
      return null;
    } else {
      return stds.get(0);
    }
  }
  @SuppressWarnings("unchecked")
  public String index() throws Exception {
    Student me = getLoginStudent();
    Date now = new Date(System.currentTimeMillis());
    List<Student> students = Collections.singletonList(me);
    ReportTemplate template = null;
    String templateName = get("template");
    if (null != templateName) template = reportTemplateService.getTemplate(me.getProject(), templateName);
    Map<String, String> options = CollectUtils.newHashMap();
    if (null != template) options = new Gson().fromJson(template.getOptions(), Map.class);
    if (null == options) options = CollectUtils.newHashMap();
    for (TranscriptDataProvider provider : dataProviderRegistry.getProviders(options.get("providers"))) {
      put(provider.getDataName(), provider.getDatas(students, options));
    }
    put("date", now);
    put("school", me.getProject().getSchool());
    put("students", students);
    List<Graduation> stdGraduations = entityDao.get(Graduation.class, "std", students);
    Map<String, Graduation> graduationMap = CollectUtils.newHashMap();
    for (Graduation graduation : stdGraduations) {
      graduationMap.put(graduation.getStd().getId().toString(), graduation);
    }
    put("graduationMap", graduationMap);
    put("GA", Model.newInstance(GradeType.class, GradeType.GA_ID));
    put("MAKEUP_GA", Model.newInstance(GradeType.class, GradeType.MAKEUP_GA_ID));
    put("RESTUDY", CourseTakeType.Repeat);
    put("printFlag", true);
    if (null == template) return forward();
    else {
      String templatePath = template.getTemplate();
      if (templatePath.startsWith("freemarker:"))
        templatePath = templatePath.substring("freemarker:".length());
      if (templatePath.endsWith(".ftl")) templatePath = Strings.substringBeforeLast(templatePath, ".ftl");
      return forward(templatePath);
    }
  }

  public void setReportTemplateService(ReportTemplateService reportTemplateService) {
    this.reportTemplateService = reportTemplateService;
  }

  public void setDataProviderRegistry(SpringTranscriptDataProviderRegistry dataProviderRegistry) {
    this.dataProviderRegistry = dataProviderRegistry;
  }

}
