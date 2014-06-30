Gem::Specification.new do |s|
  s.name        = 'od4d'
  s.version     = "0.0.0"
  s.version     = "#{s.version}.#{ENV['SNAP_PIPELINE_COUNTER']}" if ENV['SNAP'] == "true"
  s.date        = Date.today.to_s
  s.summary     = "RSS RDF to turtle converter, using http://schema.org/Article vocabulary."
  s.description = "RSS RDF to turtle converter, using http://schema.org/Article vocabulary."
  s.authors     = ["W3CBrasil", "Yasodara Cordova", "Jean Kirchner", "Marcelo Vargas", "Marcus Rodrigues", "Rafael Magrin"]
  s.email       = 'w3c-od4d@thoughtworks.com'
  s.files       = Dir["lib/*"]
  s.homepage    = 'https://github.com/W3CBrasil/od4d-rss-to-turtle'
  s.license     = '?'
end
