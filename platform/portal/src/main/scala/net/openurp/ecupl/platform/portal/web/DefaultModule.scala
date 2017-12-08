package net.openurp.ecupl.platform.portal.web

import org.beangle.commons.cache.ehcache.EhCacheManager
import org.beangle.commons.cdi.bind.AbstractBindModule

import net.openurp.ecupl.platform.portal.news.helper.NewsCrawler
import net.openurp.ecupl.platform.portal.web.action.{ AvatarAction, IndexAction, LoginAction, StudyAction, TeachingAction }

/**
 * @author chaostone
 */
class DefaultModule extends AbstractBindModule {

  override def binding() {
    bind(classOf[IndexAction], classOf[LoginAction], classOf[AvatarAction], classOf[StudyAction], classOf[TeachingAction])

    bind("cache.Ehcache.news", classOf[EhCacheManager]).constructor("ehcache-news", false)
    bind(classOf[NewsCrawler]).constructor(ref("cache.Ehcache.news"))

  }
}