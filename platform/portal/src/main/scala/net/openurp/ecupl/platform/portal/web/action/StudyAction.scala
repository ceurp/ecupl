package net.openurp.ecupl.platform.portal.web.action

import org.beangle.webmvc.api.context.ActionContext
import org.beangle.webmvc.api.view.View
import org.openurp.app.Urp

class StudyAction extends AbstractPortalAction {

  def index(): View = {
    put("static_base", ActionContext.current.request.getContextPath + "/static")
    put("theme", "blue")
    put("self_action", "/study/index")
    
    val user = getUser
    put("user",user)
    put("webappBase", Urp.webappBase)
    forward()
  }

}