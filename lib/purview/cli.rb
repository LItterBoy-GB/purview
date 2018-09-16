module Purview
  class CLI
    def self.run
      ARGV[0] = "-h" if ARGV.length==0
      OptionParser.new do |opts|
        # 这里是这个命令行工具的帮助信息
        opts.banner = 'Git权限加密版本工具'

        # Option 作为switch，不带argument，用于将 switch 设置成 true 或 false
        # 下面第一项是 Short option（没有可以直接在引号间留空），第二项是 Long option，第三项是对 Option 的描述
        opts.on('-c', '--commit', '提交本地代码') do

        end

        # Option 作为 flag，带argument，用于将argument作为数值解析，比如"name"信息
        #下面的“value”就是用户使用时输入的argument
        opts.on('-p', '--pull', '更新远程代码') do

        end
      end.parse!
    end
  end
end