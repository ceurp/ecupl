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

import java.time.Duration;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.beangle.commons.bean.comparators.MultiPropertyComparator;
import org.beangle.commons.collection.CollectUtils;
import org.beangle.commons.dao.query.builder.OqlBuilder;
import org.openurp.code.edu.model.GradeType;
import org.openurp.edu.base.model.Semester;
import org.openurp.edu.base.model.Student;
import org.openurp.edu.grade.Grade;

import org.openurp.edu.grade.course.model.CourseGrade;
import org.openurp.edu.grade.course.model.StdGpa;
import org.openurp.edu.grade.course.service.CourseGradeProvider;
import org.openurp.edu.grade.course.service.GpaStatService;
import org.openurp.edu.web.action.StudentProjectSupport;

/**
 * 学生成绩
 */
public class CourseAction extends StudentProjectSupport {

  protected GpaStatService gpaStatService;

  protected CourseGradeProvider courseGradeProvider;

  public String innerIndex() {
    Student std = getLoginStudent();
    List<CourseGrade> grades = courseGradeProvider.getPublished(std);
    StdGpa stdGpa = null;
    OqlBuilder<StdGpa> query = OqlBuilder.from(StdGpa.class, "gpa");
    query.where("gpa.std = :std", std);
    List<StdGpa> exists = entityDao.search(query);
    if (exists.isEmpty()) {
      stdGpa = gpaStatService.stat(std, grades);
      entityDao.saveOrUpdate(stdGpa);
    } else {
      stdGpa = exists.get(0);
      if (!((System.currentTimeMillis() - stdGpa.getUpdatedAt().getTime()) < Duration.ofMinutes(5)
          .toMillis())) {
        gpaStatService.refresh(stdGpa, grades);
        entityDao.saveOrUpdate(stdGpa);
      }
    }
    put("stdGpa", stdGpa);

    List<GradeType> gradeTypes = codeService.getCodes(GradeType.class, GradeType.USUAL_ID,
        GradeType.MIDDLE_ID, GradeType.END_ID, GradeType.MAKEUP_ID, GradeType.DELAY_ID, GradeType.GA_ID);
    Set<GradeType> publishedGradeTypes = new HashSet<GradeType>();
    Map<Semester, List<CourseGrade>> semesterGrades = CollectUtils.newHashMap();
    for (CourseGrade cg : grades) {
      for (GradeType gt : gradeTypes) {
        Grade g = cg.getGrade(gt);
        if (null != g && g.isPublished()) publishedGradeTypes.add(gt);
      }
      List<CourseGrade> sgs = semesterGrades.get(cg.getSemester());
      if (null == sgs) {
        sgs = new ArrayList<CourseGrade>();
        semesterGrades.put(cg.getSemester(), sgs);
      }
      sgs.add(cg);
    }
    put("semesterGrades", semesterGrades);
    Collections.sort(grades, new MultiPropertyComparator("semester.code desc,course.code"));
    put("grades", grades);
    put("gradeTypes", new ArrayList<GradeType>(publishedGradeTypes));
    return forward();
  }

  public void setGpaStatService(GpaStatService gpaStatService) {
    this.gpaStatService = gpaStatService;
  }

  public void setCourseGradeProvider(CourseGradeProvider courseGradeProvider) {
    this.courseGradeProvider = courseGradeProvider;
  }

}
