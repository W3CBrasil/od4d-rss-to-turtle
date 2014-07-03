require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


namespace :gem do

  desc "Remove old gem files"
  task :clean do
    sh "rm -f rss_to_turtle*.gem"
  end

  desc "Build gem file"
  task :build => :clean do
    sh "gem build rss_to_turtle.gemspec"
  end

  desc "Uninstall gem"
  task :uninstall do
    sh "sudo gem uninstall rss_to_turtle"
  end

  desc "Install gem"
  task :install => [:uninstall, :build] do
    sh "sudo gem install rss_to_turtle*.gem"
  end

end
