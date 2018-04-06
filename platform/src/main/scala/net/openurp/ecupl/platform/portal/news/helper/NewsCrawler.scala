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
package net.openurp.ecupl.platform.portal.news.helper

import java.io.BufferedReader
import java.net.HttpURLConnection
import java.net.URL
import java.nio.charset.Charset
import java.util.regex.Pattern

import org.beangle.commons.io.IOs
import org.beangle.commons.lang.Strings

import net.openurp.ecupl.platform.portal.news.model.News
import org.beangle.cache.Cache
import org.beangle.cache.CacheManager

object NewsCrawler {
  val newsItemPattern = Pattern.compile("""<a\shref='(.*?)'(.*?)>(.*)</a>(.*?)nowrap>(.*?)</td>""")
  val newsWebsite = "http://www.crjy.ecupl.edu.cn"
//  val newsWebsite = "http://localhost"
  val yedaNewsUrl = newsWebsite + "/s/2/t/1/p/1/c/12/list.jspy"
  val examNewsUrl = newsWebsite + "/s/2/t/1/p/1/c/13/list.jspy"
  def parse(rawHtml: String): java.util.ArrayList[News] = {
    val lines = Strings.substringBetween(rawHtml, "newslist>", "条记录")
    val matcher = newsItemPattern.matcher(lines)
    val news = new java.util.ArrayList[News]
    while (matcher.find()) {
      val newsLine = lines.substring(matcher.start, matcher.end)
      val href = newsWebsite + matcher.group(1)
      val title = matcher.group(3)
      val date = matcher.group(5)
      news.add(News(title, href, date))
    }
    news
  }
}
/**
 * @author chaostone
 */
class NewsCrawler(cacheManager: CacheManager) {
  private val cacheName = "news"
  private val cache: Cache[String, java.util.ArrayList[News]] = cacheManager.getCache(cacheName, classOf[String], classOf[java.util.ArrayList[News]])
  private val yedaNewsKey = "yedaNews"
  private val examNewsKey = "examNews"

  private def getNews(key: String, newsUrl: String): java.util.List[News] = {
    val data = cache.get(key)
    if (data.isDefined) return data.get

    var in: BufferedReader = null
    try {
      val conn = new URL(newsUrl).openConnection().asInstanceOf[HttpURLConnection]
      conn.setConnectTimeout(5 * 1000)
      conn.setReadTimeout(5 * 1000)
      conn.setRequestMethod("GET")
      conn.setDoOutput(true)
      val news = NewsCrawler.parse(IOs.readString(conn.getInputStream(), Charset.forName("UTF-8")))
      cache.put(key, news)
      news
    } catch {
      case e: Throwable =>
        e.printStackTrace();
        new java.util.ArrayList[News]
    } finally {
      if (in != null) in.close()
    }
  }
  def getYedaNews(): java.util.List[News] = {
    getNews(yedaNewsKey, NewsCrawler.yedaNewsUrl)
  }
  def getExamNews(): java.util.List[News] = {
    getNews(examNewsKey, NewsCrawler.examNewsUrl)
  }

}
