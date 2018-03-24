package net.openurp.ecupl.platform.portal.web

import net.openurp.ecupl.platform.portal.news.helper.NewsCrawler
import net.openurp.ecupl.platform.portal.web.action.{ AvatarAction, IndexAction, LoginAction, StudyAction, TeachingAction }
import org.beangle.cdi.bind.BindModule
import org.beangle.cache.ehcache.EhCacheManager

/**
 * @author chaostone
 */
class DefaultModule extends BindModule {

  override def binding() {
    bind(classOf[IndexAction], classOf[LoginAction], classOf[AvatarAction], classOf[StudyAction], classOf[TeachingAction])

    bind("cache.Ehcache.news", classOf[EhCacheManager]).constructor("ehcache-news", false)
    bind(classOf[NewsCrawler]).constructor(ref("cache.Ehcache.news"))

  }
}