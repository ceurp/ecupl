/*
 * OpenURP, Agile University Resource Planning Solution.
 *
 * Copyright © 2005, The OpenURP Software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package net.openurp.ecupl.platform.portal.web.action

import org.beangle.commons.web.util.RequestUtils
import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.api.action.ServletSupport
import org.beangle.webmvc.api.context.ActionContext
import org.beangle.webmvc.api.view.View
import org.beangle.security.realm.cas.Cas
import org.openurp.app.Urp
import org.openurp.platform.security.model.FuncPermission

import net.openurp.ecupl.platform.portal.news.helper.NewsCrawler

/**
 * @author chaostone
 */
class IndexAction extends AbstractPortalAction with ServletSupport {

  var newsCrawler: NewsCrawler = _

  def index(): View = {
    put("static_base", ActionContext.current.request.getContextPath + "/static")
    put("theme", "blue")
    put("self_action", "/index/index")
    put("client", RequestUtils.getIpAddr(ActionContext.current.request))
    val user = getUser

    put("webappBase", Urp.webappBase)
    put("yedaNewsUrl", NewsCrawler.yedaNewsUrl)
    put("examNewsUrl", NewsCrawler.examNewsUrl)
    put("yedaNews", newsCrawler.getYedaNews())
    put("examNews", newsCrawler.getExamNews())

    val apps = entityDao.search(OqlBuilder.from[App](classOf[FuncPermission].getName, "fp").join("fp.role.members", "m")
      .where("m.user=:user and m.member=true", user)
      .where("fp.resource.app.enabled=true")
      .where("fp.resource.app.appType='web-app'")
      .select("distinct fp.resource.app"))
    put("apps", apps)
    put("user", user)
    forward()
  }

  def logout(): View = {
    redirect(to(Cas.cleanup(casConfig, request, response)), null)
  }
}
