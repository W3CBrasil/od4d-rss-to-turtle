require 'time'

class Logger
  def self.log(type, message)
    output = type == :error ? $stderr : $stdout
    output.puts "#{Time.now.utc.iso8601} - #{type.upcase}: #{message}"
  end
end
