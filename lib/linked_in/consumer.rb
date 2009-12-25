# 
# 

module LinkedIn
  class Consumer
    attr_reader :oauth_consumer, :access_token, :options
    
    def initialize(oauth_consumer, access_token)
      @oauth_consumer = oauth_consumer
      @request_resource = Request.new(oauth_consumer, access_token, oauth_consumer.options)
    end
    
    def get_connections
      @request_resource.get('http://api.linkedin.com/v1/people/~/connections')
    end
    
    def get_profile
      @request_resource.get('http://api.linkedin.com/v1/people/~')
    end
    
    def search_people(query)
      @request_resource.get('http://api.linkedin.com/v1/people?' + query)
    end
  end
end
