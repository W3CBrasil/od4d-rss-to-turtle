require 'net/http'
require 'log'

class FusekiUtils
  HOST = 'localhost'
  PORT = '3030'
  PATH = '/articles/data?default'

  def self.put(data)
    begin
      Logger.log(:info, "Loading data in to semantic repository")

      headers = {}
      headers["Content-Type"] = "text/turtle;charset=utf-8;charset=utf-8"
      request = Net::HTTP::Post.new(PATH)
      request.initialize_http_header(headers)
      request.body = data
      response = Net::HTTP.new(HOST, PORT).start {|http| http.request(request) }

      if response.kind_of? Net::HTTPSuccess
        Logger.log(:info, "Data loaded successfully.")
      else
        Logger.log(:error, "Failed to load data: #{response.code}")
        Logger.log(:error, "Response body: #{response.body}")
      end

    rescue => e
      Logger.log(:error, "Error on fetch_and_load for requested data: #{e}")
      raise e
    end
  end
end

