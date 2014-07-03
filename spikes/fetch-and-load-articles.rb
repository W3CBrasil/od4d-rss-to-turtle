#!/usr/bin/env ruby

require 'net/http'
require 'rss_to_turtle'

feed_url = URI('http://webfoundation.org/feed/')

puts "Converting rss to turtle"
turtle = RSSToTurtle.convert_from_url(feed_url)

puts "Loading data in to semantic repository"

host = 'localhost'
port = '3030'
path = '/articles/data?default'

headers = {}
headers["Content-Type"] = "text/turtle;charset=utf-8;charset=utf-8"

request = Net::HTTP::Put.new(path)
request.initialize_http_header(headers)
request.body = turtle

response = Net::HTTP.new(host, port).start {|http| http.request(request) }

if response.kind_of? Net::HTTPSuccess
  puts "Data loaded successfully."
else
  puts "Failed to load data: #{response.code}"
end
