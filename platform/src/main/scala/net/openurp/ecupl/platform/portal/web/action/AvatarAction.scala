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

import java.io.File

import org.beangle.commons.lang.ClassLoaders
import org.beangle.webmvc.api.action.ActionSupport
import org.beangle.webmvc.api.view.{ Stream, View }
import org.openurp.app.UrpApp
import org.openurp.app.Urp
import org.beangle.security.Securities

class AvatarAction extends ActionSupport {

  def index(): View = {
    val avatarBase = UrpApp.properties.get("avatar_base").getOrElse(Urp.home + "/files/avatar")
    val avatarFile = new File(avatarBase + "/" + Securities.user+".jpg")
    if (avatarFile.exists()) {
      Stream(avatarFile)
    } else {
      Stream(ClassLoaders.getResource("static/images/nopic.jpg").get)
    }
  }
}
