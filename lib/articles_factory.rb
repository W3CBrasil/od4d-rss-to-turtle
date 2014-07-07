require 'article'

class ArticlesFactory
  def create(rss)
    articles = []
    rss.items.map do |item|
      article = Article.new(get_item_prop(item.link))
      gather_required_properties(article, item)
      gather_optional_properties(article, item, rss.rss_version)
      articles.push(article)
    end
    articles
  end

  private

  def gather_required_properties(article, rss_item)
    article.title = get_item_prop(rss_item.title)
    article.description  = get_item_prop(rss_item.description)
  end

  def gather_optional_properties(article, rss_item, rss_version)
    article.datePublished = get_date(rss_item.date, rss_version)
    article.author = get_item_prop(rss_item.dc_creator)
    article.articleBody = get_item_prop(rss_item.content_encoded)
    article.articleSection = rss_item.category if rss_item.respond_to?(:category)
    article.language = get_item_prop(rss_item.dc_language)
  end

  def get_item_prop(prop)
    prop.to_s.strip
  end

  def get_date(date, rss_version)
    striped_date = get_item_prop(date)
    if !striped_date.empty?
      rss_version == "2.0" ? DateTime.rfc2822(striped_date) : DateTime.iso8601(striped_date)
    end
  end

end
