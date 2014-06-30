require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :clean do
  system "rm rss_to_turtle*.gem"
end

task :build => :clean do
  system "gem build rss_to_turtle.gemspec"
end

task :uninstall do
  system "sudo gem uninstall rss_to_turtle"
end

task :install => [:uninstall, :build] do
  system "sudo gem install rss_to_turtle*.gem"
end
