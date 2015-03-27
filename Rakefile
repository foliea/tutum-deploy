$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'tutum'

config = Tutum.config

desc 'Build config file in build directory'
task :build do
  config.build
end

namespace :stack do
  stack = Tutum.stack

  desc 'Create stack on tutum'
  task :create => :build do
    stack.create
  end

  desc 'Update stack on tutum'
  task :update => :build do
    stack.update
  end

  desc 'Redeploy stack on tutum'
  task :redeploy do
    stack.redeploy
  end

  task :all do
    if stack.exists?
      Rake::Task['stack:update'].invoke
    else
      Rake::Task['stack:create'].invoke
    end
    Rake::Task['stack:redeploy'].invoke
  end
end

task :stack => 'stack:all'
task :default => [:stack]
