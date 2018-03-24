package net.openurp.ecupl.platform.portal.web.action

import org.beangle.security.realm.cas.CasConfig
import org.beangle.webmvc.api.action.ActionSupport
import org.openurp.platform.user.model.User
import org.beangle.security.Securities
import org.beangle.data.dao.EntityDao

class AbstractPortalAction extends ActionSupport {
  var entityDao: EntityDao = _
  var casConfig: CasConfig = _

  def getUser: User = {
    val userCode = Securities.user
    val users = entityDao.findBy(classOf[User], "code", List(userCode))
    users.head
  }
}