require 'mustache'
require 'yaml'

class Config
  attr_reader :build_file

  def initialize(project, build)
    @tmpl_file  = "/config/templates/#{project}.yml"
    @vars_file  = "/config/vars/#{project}/#{build}.yml"
    @build_file = "build/#{project}-#{build}.yml"
  end

  def build
    File.write(@build_file, content)
  end

  private

  def content
    Mustache.render(template, config: vars)
  end

  def vars
    YAML::load_file(@vars_file)
  end

  def template
    File.read(@tmpl_file)
  end
end
