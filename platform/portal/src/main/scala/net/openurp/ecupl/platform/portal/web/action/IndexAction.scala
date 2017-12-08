package net.openurp.ecupl.platform.portal.web.action

import org.beangle.commons.dao.OqlBuilder
import org.beangle.commons.web.util.RequestUtils
import org.beangle.security.context.SecurityContext
import org.beangle.security.mgt.SecurityManager
import org.beangle.webmvc.api.context.ActionContext
import org.beangle.webmvc.api.view.View
import org.openurp.platform.api.Urp
import org.openurp.platform.config.model.App
import org.openurp.platform.security.model.FuncPermission

import net.openurp.ecupl.platform.portal.news.helper.NewsCrawler

/**
 * @author chaostone
 */
class IndexAction extends AbstractPortalAction {
 
  var securityManager: SecurityManager = _
  var newsCrawler: NewsCrawler = _

  def index(): String = {
    put("static_base", ActionContext.current.request.getContextPath + "/static")
    put("theme", "blue")
    put("self_action", "/index/index")
    put("client", RequestUtils.getIpAddr(ActionContext.current.request))
    val user = getUser
    
    put("webappBase", Urp.webappBase)
    put("yedaNewsUrl",NewsCrawler.yedaNewsUrl)
    put("examNewsUrl",NewsCrawler.examNewsUrl)
    put("yedaNews", newsCrawler.getYedaNews())
    put("examNews", newsCrawler.getExamNews())

    val apps = entityDao.search(OqlBuilder.from[App](classOf[FuncPermission].getName, "fp").join("fp.role.members", "m")
      .where("m.user=:user and m.member=true", user)
      .where("fp.resource.app.enabled=true")
      .where("fp.resource.app.appType='web-app'")
      .select("distinct fp.resource.app"))
    put("apps", apps)
    put("user", user)
    put("casConfig", casConfig)
    forward()
  }

  def logout(): View = {
    securityManager.logout(SecurityContext.session)
    redirect(to(casConfig.casServer + "/logout"), null)
  }
}