package net.openurp.ecupl.platform.portal.news.helper

import org.beangle.commons.io.IOs
import org.beangle.commons.lang.ClassLoaders
import org.junit.runner.RunWith
import org.scalatest.FunSpec
import org.scalatest.Matchers
import org.scalatest.junit.JUnitRunner

/**
 * @author chaostone
 */
@RunWith(classOf[JUnitRunner])
class NewsCrawlerTest extends FunSpec with Matchers {
  describe("NewsCrawler") {
    it("parse") {
      val lines = IOs.readString(ClassLoaders.getResourceAsStream("yeda_news.html").get)
      val news = NewsCrawler.parse(lines)
      println(news)
    }
  }
}
