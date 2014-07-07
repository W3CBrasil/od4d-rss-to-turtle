require 'article'
require 'htmlentities'

class ArticlesFactory
  def create(rss)
    articles = []
    rss.items.map do |item|
      article = Article.new(strip_prop(item.link))
      gather_required_properties(article, item)
      gather_optional_properties(article, item, rss.rss_version)
      articles.push(article)
    end
    articles
  end

  private

  def gather_required_properties(article, rss_item)
    article.title = strip_html(strip_prop(rss_item.title))
    article.description  = strip_html(strip_prop(rss_item.description))
  end

  def gather_optional_properties(article, rss_item, rss_version)
    article.datePublished = get_date(rss_item.date, rss_version)
    article.author = strip_prop(rss_item.dc_creator)
    article.articleBody = strip_html(strip_prop(rss_item.content_encoded))
    article.articleSection = get_category(rss_item)
    article.language = strip_prop(rss_item.dc_language)
  end

  def get_category(rss_item)
    if rss_item.respond_to?(:categories) then
        categories = rss_item.categories.map do |cat|
            cat.content
        end
        categories.join(",")
    else
        ""
    end
  end

  def strip_prop(prop)
    prop.to_s.strip
  end

  def strip_html(str)
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    str.gsub!(re, '')
    replace_html_codes(str)
  end

  def replace_html_codes(str)
    return HTMLEntities.new.decode(str)
  end

  def get_date(date, rss_version)
    striped_date = strip_prop(date)
    if !striped_date.empty?
      rss_version == "2.0" ? DateTime.rfc2822(striped_date) : DateTime.iso8601(striped_date)
    end
  end
end
