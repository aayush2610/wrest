module Wrest
  class Uri
    def initialize(uri_string)
      @uri = URI.parse(uri_string)
    end
    
    def get(headers = {})
      # http.request(Net::HTTP::Get.new(@uri.path, headers))
      http.get(@uri.path, headers)
    end
  
    def put(body = '', headers = {})
      http.put(@uri.path, body.to_s, headers)
    end
  
    def post(body = '', headers = {})
      http.post(@uri.path, body.to_s, headers)
    end
  
    def delete(headers = {})
      http.delete(@uri.path, headers)
    end
    
    def https?
      @uri.is_a?(URI::HTTPS)
    end
    
    def http
      http             = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl     = true if https?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl
      http
    end  
  end
end