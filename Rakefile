require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :gem do

  desc "Remove old gem files"
  task :clean do
    sh "rm -rf output"
  end

  desc "Build gem file"
  task :build => :clean do
    sh "mkdir output"
    sh "gem build rss-to-turtle.gemspec"
    sh "mv rss-to-turtle*.gem output/"
  end

  desc "Uninstall gem"
  task :uninstall do
    sh "sudo gem uninstall -x rss-to-turtle"
  end

  desc "Install gem"
  task :install => [:uninstall, :build] do
    sh "sudo gem install output/rss-to-turtle*.gem"
  end

end

desc "Deploy application to production server"
task :deploy do
  command = <<-eos
    cd /tmp
    gem install rss-to-turtle --install-dir ~/.gem
    crontab -l | grep -v fetch-and-load-articles | { cat; echo "*/30 * * * * fetch-and-load-articles"; } | crontab -
    rm rss-to-turtle*.gem
  eos

  sh "scp output/rss-to-turtle*.gem od4d@#{ENV['OD4D_PROD_SERVER']}:/tmp"
  sh "ssh od4d@#{ENV['OD4D_PROD_SERVER']} '#{command}'"
end
