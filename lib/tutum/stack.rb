module Tutum
  class Stack < Struct.new(:name, :file)
    def exists?
      system "tutum stack inspect #{name} > /dev/null"
    end

    def create
      puts "Creating #{name}..."
      sh "tutum stack create --file #{file} --name #{name}"
      puts "Created!"
    end

    def update
      puts "Updating #{name}..."
      sh "tutum stack update --file #{file} #{name}"
      puts "Updated!"
    end

    def redeploy
      puts "Deploying #{name}..."
      sh "tutum stack redeploy #{name}"
      puts "#{name} is up and ready!"
    end

    private

    def sh(cmd)
      abort unless system(cmd)
    end
  end
end