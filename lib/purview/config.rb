module Purview
  class Config

    @data = {}
    @keys = %W{username password}

    def self.save
      path = ENV['APPDATA']
      path = File.join(path,".purview")
      FileUtils.makedirs path unless Dir.exist? path
      f = File.new(File.join(path,"config"), "w")
      @keys.each{|key|
        value = @data[key] ? @data[key]:""
        f.puts "#{key}:#{value}"
      }
      f.close
    end

    def self.read
      path = ENV['APPDATA']
      path = File.join(path,".purview")
      FileUtils.makedirs path unless Dir.exist? path
      file = File.join(path,"config")
      if File.exist? file
        f = File.open(File.join(path,"config"),model="r").each{|str|
          index = str.index ":"
          next unless index
          key = str[0..index-1]
          value = str[index+1..-2].gsub('\n','').gsub('\r','')
          @data[key] = value if @keys.include? key
        }
        f.close
      end
    end

    def self.[](key)
      @data[key] if @data[key]
    end

    def self.[]=(key,value)
      (@data[key] = value;save) if @keys.include? key
    end

  end
end
