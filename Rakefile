require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


namespace :gem do

  desc "Remove old gem files"
  task :clean do
    sh "rm -f rss-to-turtle*.gem"
  end

  desc "Build gem file"
  task :build => :clean do
    sh "gem build rss-to-turtle.gemspec"
  end

  desc "Uninstall gem"
  task :uninstall do
    sh "sudo gem uninstall rss-to-turtle"
  end

  desc "Install gem"
  task :install => [:uninstall, :build] do
    sh "sudo gem install rss-to-turtle*.gem"
  end

end
