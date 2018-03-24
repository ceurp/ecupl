package net.openurp.ecupl.platform.portal.web.action

import org.beangle.webmvc.api.action.ActionSupport
import org.beangle.webmvc.api.view.View

/**
 * @author chaostone
 */
class LoginAction extends ActionSupport {
  def index(): View = {
    redirect(to(classOf[IndexAction], "index"), null)
  }

}