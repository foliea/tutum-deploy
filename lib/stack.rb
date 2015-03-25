class Stack < Struct.new(:name, :file)
  def exists?
    system "tutum stack inspect #{name}"
  end

  def update
    sh "tutum stack update --file #{file} #{name}"
  end

  def create
    sh "tutum stack create --file #{file} --name #{name}"
  end

  def deploy
    sh "tutum stack redeploy #{name}"
  end

  private

  def sh(cmd)
    abort unless system(cmd)
  end
end
