require 'article'

class ArticlesFactory
  def create(rss)
    articles = []
    rss.items.map do |item|
      article = Article.new(get_item_prop(item.link))
      gather_required_properties(article, item)
      gather_optional_properties(article, item)
      articles.push(article)
    end
    articles
  end

  private

  def gather_required_properties(article, rss_item)
    article.title = get_item_prop(rss_item.title)
    article.description  = get_item_prop(rss_item.description)
  end

  def gather_optional_properties(article, rss_item)
    article.datePublished = get_date(rss_item.pubDate) if rss_item.respond_to?(:pubDate)
    article.author = get_item_prop(rss_item.dc_creator) if rss_item.respond_to?(:dc_creator)
    article.articleBody = get_item_prop(rss_item.content_encoded) if rss_item.respond_to?(:content_encoded)
    article.articleSection = rss_item.category if rss_item.respond_to?(:category)
    article.language = get_item_prop(rss_item.dc_language) if rss_item.respond_to?(:dc_language)
  end

  def get_item_prop(prop)
    if (prop != nil) then
        prop = prop.to_s.strip
    end
    prop
  end

  def get_date(prop)
    striped_prop = get_item_prop(prop)
    DateTime.rfc2822(striped_prop) if !striped_prop.nil?
  end

end
