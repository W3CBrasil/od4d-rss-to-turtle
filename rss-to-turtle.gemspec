Gem::Specification.new do |s|
  s.name        = 'rss-to-turtle'
  s.version     = "0.0.1"
  s.version     = "#{s.version}.#{ENV['SNAP_PIPELINE_COUNTER']}" if ENV['SNAP_CI'] == "true"
  s.date        = Date.today.to_s
  s.summary     = "RSS RDF to turtle converter, using http://schema.org/Article vocabulary."
  s.description = "RSS RDF to turtle converter, using http://schema.org/Article vocabulary."
  s.authors     = [ "W3CBrasil" ]
  s.files       = Dir["lib/*"] + Dir["bin/*"]
  s.executables = 'fetch-and-load-articles'
  s.homepage    = 'https://github.com/W3CBrasil/od4d-rss-to-turtle'
  s.license     = 'MIT'

  s.add_dependency 'rdf-turtle', '~> 1.1', '>= 1.1.4'
  s.add_dependency 'htmlentities', '~> 4.3.2'

end
