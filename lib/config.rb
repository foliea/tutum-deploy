require 'mustache'
require 'yaml'

class Config
  attr_reader :project, :build_env, :build_file

  def initialize(project, build_env)
    @project    = project
    @build_env  = build_env
    @tmpl_file  = "/config/templates/#{project}.yml"
    @vars_file  = "/config/vars/#{project}/#{build_env}.yml"
    @build_file = "build/#{project}-#{build_env}.yml"
  end

  def build
    puts "Building #{@build_file}..."
    File.write(@build_file, content)
    puts File.read(@build_file)
    puts "Built!"
  end

  private

  def content
    p vars
    Mustache.render(template, config: vars)
  end

  def vars
    YAML::load_file(@vars_file).merge(default_vars)
  end

  def template
    File.read(@tmpl_file)
  end

  def default_vars
    { project: @project, build_env: @build_env }
  end
end
