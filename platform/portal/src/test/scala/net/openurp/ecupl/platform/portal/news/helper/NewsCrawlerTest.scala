package net.openurp.ecupl.platform.portal.news.helper

import org.junit.runner.RunWith
import org.openurp.platform.api.app.UrpApp
import org.scalatest.Matchers
import org.scalatest.FunSpec
import org.scalatest.junit.JUnitRunner
import org.beangle.commons.io.IOs
import org.beangle.commons.lang.ClassLoaders

/**
 * @author chaostone
 */
@RunWith(classOf[JUnitRunner])
class NewsCrawlerTest extends FunSpec with Matchers {
  describe("NewsCrawler") {
    it("parse") {
      val lines = IOs.readString(ClassLoaders.getResourceAsStream("yeda_news.html"))
      val news = NewsCrawler.parse(lines)
      println(news)
    }
  }
}
