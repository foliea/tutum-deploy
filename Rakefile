$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'config'
require 'stack'

PROJECT = ENV.fetch('PROJECT')
BUILD   = ENV.fetch('BUILD')

config = Config.new(PROJECT, BUILD)

desc 'Build config file in build directory'
task :build do
  puts "Building #{config.build_file}..."

  config.build

  puts "Built!"
end

namespace :stack do
  STACK = ENV.fetch('STACK', "#{PROJECT}-#{BUILD}")

  stack = Stack.new(STACK, config.build_file)

  desc 'Create stack on tutum'
  task :create => :build do
    puts "Creating #{stack.name}..."

    stack.create

    puts "Created!"
  end

  desc 'Update stack on tutum'
  task :update => :build do
    puts "Updating #{stack.name}..."

    stack.update

    puts "Updated!"
  end

  desc 'Redeploy stack on tutum'
  task :deploy do
    puts "Deploying #{stack.name}..."

    stack.deploy

    puts "#{stack.name} is up and ready!"
  end

  task :all do
    if stack.exists?
      Rake::Task['stack:update'].invoke
    else
      Rake::Task['stack:create'].invoke
    end
    Rake::Task['stack:deploy'].invoke
  end
end
