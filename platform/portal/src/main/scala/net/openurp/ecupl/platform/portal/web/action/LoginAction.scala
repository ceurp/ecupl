package net.openurp.ecupl.platform.portal.web.action

import org.beangle.webmvc.api.action.ActionSupport
import org.beangle.webmvc.api.action.To
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.api.context.ActionContext
import org.beangle.security.realm.cas.CasConfig
import org.openurp.platform.api.security.Securities
import org.openurp.platform.api.app.UrpApp
import org.openurp.platform.api.Urp
import org.beangle.commons.web.util.HttpUtils

/**
 * @author chaostone
 */
class LoginAction extends ActionSupport {
  def index(): View = {
    redirect(to(classOf[IndexAction],"index"), null)
  }

}