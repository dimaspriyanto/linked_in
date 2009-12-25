# 
# 

module LinkedIn
  class Request
    def initialize(consumer, access_token, options)
      @consumer, @access_token, @options = consumer, access_token, options
    end
    
    def get(resource)
      perform_request(:get, resource)
    end
    
    def post(resource)
      perform_request(:post, resource)
    end
    
    def put(resource)
      perform_request(:put, resource)
    end
    
    def delete(resource)
      perform_request(:delete, resource)
    end
    
  private    
    def perform_request(http_method, resource, options={})
      request = @consumer.request(http_method, resource, @access_token, @options)
      parse_response(request)
    end
    
    def parse_response(request)
      request.body
    end
  end
end
