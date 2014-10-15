require 'article'
require 'htmlentities'
require 'log'

class ArticlesFactory
  def create(rss)
    articles = []
    rss.items.map do |item|
      article = Article.new(sanitize_prop(item.link))
      gather_header_properties(article, rss)
      gather_required_properties(article, item)
      gather_optional_properties(article, item, rss.rss_version)
      fill_language(article, rss.channel)
      if article.valid?
        articles.push(article)
      end
    end
    articles
  end

  private

  def fill_language(article, channel)
    has_language = channel.class.method_defined? :language
    has_dc_language = channel.class.method_defined? :dc_language
    article.language = channel.language[0..1] if has_language && !channel.language.nil? && !channel.language.empty?
    article.language = channel.dc_language[0..1] if has_dc_language && !channel.dc_language.nil? && !channel.dc_language.empty?
  end

  def gather_header_properties(article, rss)
    uri = URI(rss.channel.link)
    @copyright = get_copyright(rss)
    article.publisher = "#{uri.scheme}://#{uri.host}"
  end

  def gather_required_properties(article, rss_item)
    article.title = sanitize_prop(rss_item.title)
    article.description  = sanitize_prop(rss_item.description)
  end

  def gather_optional_properties(article, rss_item, rss_version)
    article.datePublished = get_date(rss_item.date, rss_version)
    article.author = sanitize_prop(rss_item.dc_creator)
    article.articleBody = sanitize_prop(rss_item.content_encoded)
    article.articleSection = category_from rss_item
    article.about = get_categories(rss_item)
    article.enclosure = get_enclosure(rss_item)
    article.copyright = @copyright
  end

  def get_enclosure(rss_item)
    rss_item.enclosure if rss_item.respond_to?(:enclosure)
  end

  def get_copyright(rss)
    rss.channel.copyright if rss.channel.respond_to?(:copyright)
  end

  def category_from(rss_item)
    sanitize_prop rss_item.category if rss_item.respond_to?(:category)
  end

  def get_categories(rss_item)
    categories = []
    if rss_item.respond_to?(:categories) then
      rss_item.categories.map do |cat|
        categories.push(cat.content)
      end
    end
    categories
  end

  def sanitize_prop(prop)
    str = prop.to_s
    str = strip_html(str)
    str = remove_invalid_characters(str)
    str.strip
  end

  def strip_html(str)
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    str.to_s.gsub!(re, '')
    replace_html_codes(str)
  end

  def replace_html_codes(str)
    HTMLEntities.new.decode(str)
  end

  def remove_invalid_characters(str)
    str.gsub(/[\u{0096}\u{0097}]/, "")
  end

  def get_date(date, rss_version)
    striped_date = sanitize_prop(date)
    if !striped_date.empty?
      rss_version == "2.0" ? DateTime.rfc2822(striped_date) : DateTime.iso8601(striped_date)
    end
  end
end
