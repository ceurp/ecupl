package net.openurp.sfu.edu.grade;

import net.openurp.sfu.edu.grade.course.service.SfuCourseGradeCalculator;

import org.beangle.commons.inject.bind.AbstractBindModule;

public class SfuModule extends AbstractBindModule {

  @Override
  protected void doBinding() {
    bind("sfuCourseGradeCalculator",SfuCourseGradeCalculator.class).primary();
  }

}
