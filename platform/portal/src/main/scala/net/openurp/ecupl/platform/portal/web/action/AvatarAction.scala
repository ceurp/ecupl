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