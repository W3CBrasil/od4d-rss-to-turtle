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

namespace :deploy do

  def deploy(server)
    cron_job = "*/30 * * * * sh -c '. ~/.bashrc && fetch-and-load-articles' >> /var/log/od4d/fetch-and-load-articles.log 2>&1"
    command = <<-eos
      cd /tmp
      gem uninstall -x rss-to-turtle
      gem install rss-to-turtle --install-dir ~/.gem
      crontab -l | grep -v fetch-and-load-articles | { cat; echo \\"#{cron_job}\\"; } | crontab -
      rm rss-to-turtle*.gem
      . ~/.bashrc && fetch-and-load-articles
      . ~/.bashrc && insert_static_datasets
    eos

    verify_package_exist
    configure_deploy_ssh_key(server)
    sh "scp output/rss-to-turtle*.gem od4d@#{server}:/tmp"
    sh "ssh od4d@#{server} \"#{command}\""
  end

  def verify_package_exist
    raise "Gem file not found. Please run 'rake gem:build' to generate gem file." if Dir.glob('output/rss-to-turtle*.gem').empty?
  end

  def configure_deploy_ssh_key(server)
    command = <<-eos
      echo "$DEPLOY_SSH_KEY" > ~/.ssh/deploy-key
      chmod 0600 ~/.ssh/deploy-key
      printf "\nHost #{server}\nUserKnownHostsFile /dev/null\nIdentityFile ~/.ssh/deploy-key\n" >> $HOME/.ssh/config
    eos
    sh command if ENV['CI']
  end

  desc "Deploy to localhost"
  task :local => "gem:install"

  desc "Deploy to development"
  task :development do
    deploy("app-server.dev")
  end

  desc "Deploy to staging"
  task :staging do
    fail "Please set the server address using the environment variable OD4D_STAGING_SERVER" if ENV['OD4D_STAGING_SERVER'].to_s.empty?
    deploy("#{ENV['OD4D_STAGING_SERVER']}")
  end

  desc "Deploy to production"
  task :production do
    fail "Please set the server address using the environment variable OD4D_PROD_SERVER" if ENV['OD4D_PROD_SERVER'].to_s.empty?
    deploy("#{ENV['OD4D_PROD_SERVER']}")
  end

end
