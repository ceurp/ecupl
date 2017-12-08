package net.openurp.ecupl.platform.portal.web.action

import org.beangle.webmvc.api.action.ActionSupport
import org.beangle.webmvc.api.context.ActionContext
import org.openurp.platform.api.security.Securities
import org.openurp.platform.user.model.User
import org.openurp.platform.api.Urp

class TeachingAction extends AbstractPortalAction {

  
  def index(): String = {
    put("static_base", ActionContext.current.request.getContextPath + "/static")
    put("theme", "blue")
    put("self_action", "/study/index")
    
    val user = getUser
    put("user",user)
    put("webappBase", Urp.webappBase)
    forward()
  }

}