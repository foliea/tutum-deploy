require 'mustache'
require 'yaml'

class Config
  attr_reader :project, :build, :build_file

  def initialize(project, build)
    @project    = project
    @build      = build
    @tmpl_file  = "/config/templates/#{project}.yml"
    @vars_file  = "/config/vars/#{project}/#{build}.yml"
    @build_file = "build/#{project}-#{build}.yml"
  end

  def build
    puts "Building #{@build_file}..."
    File.write(@build_file, content)
    puts "Built!"
  end

  private

  def content
    Mustache.render(template, config: vars)
  end

  def vars
    YAML::load_file(@vars_file).merge(default_vars)
  end

  def template
    File.read(@tmpl_file)
  end

  def default_vars
    { project: @project, build: build }
  end
end
