# Base class 
# 
 

module LinkedIn
  class Base
    attr_reader :consumer
    
    def initialize(oauth)
      @oauth = oauth
      @consumer = Consumer.new(oauth.consumer, oauth.access_token)
      @client = Client.new
    end
    
    def connections
      @connections ||= @consumer.get_connections
    end
    
    def profile
      @profile ||= @consumer.get_profile
    end
    
    def people_search(query)
      @people_search_result ||= @consumer.search_people(query)
    end    
    
    def invite
    end
    
    def update_status
    end
    
  end
end
