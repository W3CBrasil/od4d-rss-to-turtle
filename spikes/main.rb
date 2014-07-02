require 'rss'
require 'open-uri'
require 'rss_to_turtle'

url = 'http://webfoundation.org/feed/'
puts RSSToTurtle.convert_from_url(url)
