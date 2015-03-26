$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'config'
require 'stack'

PROJECT     = ENV.fetch('PROJECT')
BUILD_ENV   = ENV.fetch('BUILD_ENV')

config = Config.new(PROJECT, BUILD_ENV)

desc 'Build config file in build directory'
task :build do
  config.build
end

namespace :stack do
  STACK = ENV.fetch('STACK', "#{PROJECT}-#{BUILD_ENV}")

  stack = Stack.new(STACK, config.build_file)

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
