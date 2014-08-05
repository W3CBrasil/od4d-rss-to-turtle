require 'resource'

class Article

  attr_reader :url
  attr_accessor :title, :description, :comment, :author, :datePublished, :articleBody, :articleSection, :language, :publisher

  def initialize(url, options={})
    raise "url can't be nil" if url.nil?
    @url = url
    @title = options[:title]
    @description = options[:description]
    @language = options[:language]
    @author = options[:author]
    @datePublished  = options[:datePublished ]
    @articleBody = options[:articleBody]
    @articleSection = options[:articleSection]
    @publisher = options[:publisher]
  end

  alias_method :uri, :url

  def add_optional_to_resource(res, field_name, field_value)
    res.add_property(field_name, field_value) unless field_value.to_s.empty?
  end

  def to_resource
    res = Resource.new(uri, "Article")
    add_optional_to_resource(res, "headline", @title)
    add_optional_to_resource(res, "uri", @uri)
    add_optional_to_resource(res, "url", @url)
    add_optional_to_resource(res, "description", @description)
    add_optional_to_resource(res, "inLanguage", @language)
    add_optional_to_resource(res, "author", @author)
    add_optional_to_resource(res, "datePublished", (@datePublished.iso8601() unless @datePublished.nil?))
    add_optional_to_resource(res, "articleBody", @articleBody)
    add_optional_to_resource(res, "articleSection", @articleSection)
    add_optional_to_resource(res, "publisher", @publisher)
    res
  end

  def valid?
    !(@title.nil? ||
    @title.empty? ||
    @publisher.nil? ||
    @publisher.empty? ||
    @description.nil? ||
    @description.empty?)
  end
end
