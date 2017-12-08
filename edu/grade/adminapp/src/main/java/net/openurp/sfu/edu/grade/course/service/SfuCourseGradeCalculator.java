package net.openurp.sfu.edu.grade.course.service;

import java.util.Set;

import org.openurp.edu.base.code.model.StdLabel;
import org.openurp.edu.base.model.Student;
import org.openurp.edu.grade.course.model.CourseGradeState;
import org.openurp.edu.grade.course.model.GaGrade;
import org.openurp.edu.grade.course.service.impl.DefaultCourseGradeCalculator;

public class SfuCourseGradeCalculator extends DefaultCourseGradeCalculator {

  private Set<Integer> labelIds;

  private Long startSemesterId;

  public Set<Integer> getLabelIds() {
    return labelIds;
  }

  public void setLabelIds(Set<Integer> labelIds) {
    this.labelIds = labelIds;
  }

  public Long getStartSemesterId() {
    return startSemesterId;
  }

  public void setStartSemesterId(Long startSemesterId) {
    this.startSemesterId = startSemesterId;
  }

  protected boolean hasDelta(GaGrade gaGrade) {
    return null != hasDeltaLabel(gaGrade.getStd());
  }

  private StdLabel hasDeltaLabel(Student std) {
    for (StdLabel label : std.getLabels().values()) {
      if (labelIds.contains(label.getId())) return label;
    }
    return null;
  }

  @Override
  protected Float getDelta(GaGrade gaGrade, Float score, CourseGradeState state) {
    if (null == score) return null;
    if (gaGrade.getCourseGrade().getSemester().getId().intValue() >= startSemesterId) {
      StdLabel label = hasDeltaLabel(gaGrade.getStd());
      double originScore = reserve(score, state);
      if (null != label) {
        Float delta = null;
        double finalScore = reserve(Math.sqrt(originScore) * 10, state);
        if (finalScore > 100) finalScore = 100;
        delta = new Float(finalScore - originScore);

        if (null != delta && delta.floatValue() > 0) {
          gaGrade.setDelta(delta);
          gaGrade.setRemark(label.getName() + " √*10");
        } else {
          gaGrade.setDelta(null);
          gaGrade.setRemark(null);
        }
        return delta;
      } else {
        return gaGrade.getDelta();
      }
    } else {
      return gaGrade.getDelta();
    }
  }

}
