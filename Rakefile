$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'tutum'

desc 'Build config file in build directory'
task :build do
  Tutum.config.build
end

namespace :stack do
  stack = Tutum.stack

  desc 'Create stack on tutum'
  task :create => :build do
    Tutum.stack.create
  end

  desc 'Update stack on tutum'
  task :update => :build do
    Tutum.stack.update
  end

  desc 'Redeploy stack on tutum'
  task :redeploy do
    Tutum.stack.redeploy
  end

  task :all do
    if stack.exists?
      Rake::Task['stack:update'].invoke
    else
      puts "Stack doesn't exist"
      Rake::Task['stack:create'].invoke
    end
    Rake::Task['stack:redeploy'].invoke
  end
end

task :stack => 'stack:all'
task :default => [:stack]
