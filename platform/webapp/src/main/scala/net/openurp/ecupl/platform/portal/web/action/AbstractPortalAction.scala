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
