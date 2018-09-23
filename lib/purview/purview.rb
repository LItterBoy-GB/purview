module Purview
  class Purview
    DOMAIN = "localhost"

    def self.login
      url = "http://#{DOMAIN}:8080/login"
      username = Config['username']
      password = Config['password']
      (puts "\"purview -U xxxx\" 设置用户名"; return) unless username
      (puts "\"purview -P xxxx\" 设置用户密码"; return) unless password
      username = username.lstrip.rstrip
      (puts "\"purview -U xxxx\" 设置正确的用户名"; return) if username == ""
      run url, {:username => username, :password => password}," -s"
    end

    def self.check_out

    end

    def self.pull
      url = "http://#{DOMAIN}:8080/version/pull"

    end

    def self.commit
      url = "http://#{DOMAIN}:8080/version/push"
      run(url, {"test/pruview" => "@E:/test/pruview.jpg","14183/Desktop/pruview" =>"C:/Users/14183/Desktop/pruview.jpg","commit"=>"asdfascd"}, cmd = " --progress-bar")
    end

    def self.down(url, file_path)
      cookie_file = File.join(path, 'cookie.txt')
      system("curl #{url} --cookie \"#{cookie_file}\" --cookie-jar \"#{cookie_file}\" --output \"#{file_path}\" --progress-bar")
    end

    def self.run(url, params, cmd = "")
      path = File.join(ENV['APPDATA'], '.purview', (Time.now.to_f * 1000).to_i.to_s).gsub "\\", "/"
      Dir.mkdir path
      cookie_file = File.join(ENV['APPDATA'], '.purview', 'cookie.txt')
      header_file = File.join(path, 'header.txt')
      output_file = File.join(path, 'output.txt')
      form_str = ""
      params.each {|k, v|
        if v.class == Array
          v.each {|item|
            form_str += " -F#{"\""}#{k}=#{item.gsub("\"", "\\\"")}#{"\""}"
          }
        else
          form_str += " -F#{"\""}#{k}=#{v.gsub("\"", "\\\"")}#{"\""}"
        end
      }
      puts form_str
      cmd = "curl#{cmd} #{url} --cookie \"#{cookie_file}\" --cookie-jar \"#{cookie_file}\" --dump-header \"#{header_file}\" --output \"#{output_file}\"#{form_str}"
      arr = []
      loop {
        system(cmd)
        (puts "访问失败!";FileUtils.rm_rf(path); return) unless File.exist? header_file
        f = File.open(header_file, model = 'r')
        line = f.gets
        arr = line.split " "
        if arr[1] == "100"
          f.gets
          line = f.gets
          arr = line.split " "
        end
        (login;next)if arr[1] == "302"
        break
      }
      (puts "访问失败!code:#{arr[1]}";FileUtils.rm_rf(path); return) if arr[1] != "200"
      line = File.read(output_file)
      FileUtils.rm_rf(path)
      return JSON.parse(line)
    end
  end
end