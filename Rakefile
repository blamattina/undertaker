require 'rubygems'
require 'bundler'
require 'rake'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Default: run the specs and features.'
task :default do
    system("bundle exec rspec spec/*")
end
