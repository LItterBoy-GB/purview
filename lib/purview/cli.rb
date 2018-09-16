module Purview
  class CLI
    def self.run
      # 检查环境
      flag = false
      ENV['PATH'].split(';').each{|path|
       (flag=true;break)  if File.file?(File.join(path,"WinMergeU.exe"))
      }
      (Log.error "请安装 WinMerge 并添加到环境变量; http://winmerge.org/downloads/";return) unless flag
      flag = false
      ENV['PATH'].split(';').each{|path|
        (flag=true;break)  if File.file?(File.join(path,"git.exe"))
      }
      (Log.error "请安装 Git 并添加到环境变量; https://git-scm.com/downloads";return) unless flag

      ARGV[0] = "-h" if ARGV.length==0
      OptionParser.new do |opts|
        # 这里是这个命令行工具的帮助信息
        opts.banner = 'Git权限加密版本工具'

        opts.on('-C', '--checkout', '检出项目') do

        end

        opts.on('-c', '--commit', '提交本地代码') do

        end

        opts.on('-p', '--pull', '更新远程代码') do

        end
      end.parse!
    end
  end
end