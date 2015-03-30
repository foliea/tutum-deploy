module Tutum
  extend self

  require_relative 'tutum/config'
  require_relative 'tutum/stack'

  def config
    @config ||= Config.new(project, build_env)
  end

  def stack
    @stack ||= Stack.new(stack_name, config.build_file)
  end

  private

  def project
    ENV.fetch('PROJECT')
  end

  def build_env
    ENV.fetch('BUILD_ENV')
  end

  def stack_name
    ENV.fetch('STACK', "#{project}-#{build_env}")
  end
end