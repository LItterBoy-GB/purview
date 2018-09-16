require 'logger'
module Purview
  class Log
    LOG_ERROR = Logger.new(STDERR)
    LOG_ERROR.datetime_format = '%Y-%m-%d %H:%M:%S'
    LOG_INFO = Logger.new(STDOUT)
    LOG_INFO.datetime_format = '%Y-%m-%d %H:%M:%S'
    def self.error(obj)
      LOG_ERROR.error obj
    end
    def self.info(obj)
      LOG_INFO.info obj
    end
  end
end