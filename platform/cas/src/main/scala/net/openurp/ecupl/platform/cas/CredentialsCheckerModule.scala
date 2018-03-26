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
package net.openurp.ecupl.platform.cas

import org.openurp.app.UrpApp
import org.beangle.security.realm.ldap.SimpleLdapUserStore
import java.io.FileInputStream
import org.beangle.cdi.bind.BindModule

class CredentialsModule extends BindModule {
  override def binding() {
    bind("security.CredentialsChecker.default", classOf[SimpleDBCredentialsChecker])
      .constructor(ref("DataSource.security"))
  }
}
