# LinkedIn OAuth API Documentation here:
# http://developer.linkedin.com/docs/DOC-1008
# 
# OAuth authorization implementation derived from "oauth" library
# http://github.com/mojodna/oauth
# 
# Authorization flow trully inspired by "twitter" library
# http://github.com/jnunemaker/twitter
#

module LinkedIn
  class Oauth
    
    # API options got fixed: 
    # http://developer.linkedin.com/docs/DOC-1008#LinkedIns_OAuth_Details_
    # 
    ApiOptions = {
      :site => 'https://api.linkedin.com',
      :request_token_path => '/uas/oauth/requestToken',
      :authorize_path     => '/uas/oauth/authorize',
      :access_token_path  => '/uas/oauth/accessToken'
    }
    
    # left options blank for now
    #   api_key = 'YOUR_APP_API_KEY'
    #   secret_key = 'YOUR_APP_SECRET_KEY'
    #   linkedin = LinkedIn::Oauth.new(api_key, secret_key)
    #
    def initialize(api_key, api_secet, options={})
      @api_key, @api_secret = api_key, api_secet
      @consumer_options = options.merge(ApiOptions)
    end
    
    # returning oauth costumer derived from oauth library
    #   linkedin.consumer
    #   #<OAuth::Consumer:0xb6f6a854 @http=#<Net::HTTP api.linked.... --truncated-- ">
    #
    def consumer
      @consumer ||= ::OAuth::Consumer.new(@api_key, @api_secret, @consumer_options)
    end
    
    # pass :oauth_callback for options it will returned token, secret and authorize_url
    #   oauth_callback = 'http://localhost:3000/linkedin_callback'
    #   linkedin.request_token :oauth_callback => oauth_callback
    # 
    # if successfull we should get these:
    #   request_token, request_secret = = linkedin.request_token.token, linkedin.request_token.secret 
    #   authorize_url = linkedin.request_token.authorize_url
    # 
    def request_token(options={})
      @request_token ||= consumer.get_request_token(options.merge(@consumer_options))
    end

    # after getting authorize url, we should redirect user to LinkedIn authorization page
    # if user authorize access to our application they will be redirected to oauth_callback url 
    # LinkedIn api will pass parameter "oauth_verifier", this is how to use it:
    #   verifier = params[:oauth_verifier]
    #   linkedin.authorize_from_request(request_token, request_secret, verifier)
    #   => ["06928252-be09-4563-ab35-xxxxxxxxxxxx", "1e1922c2-257b-4060-aecd-xxxxxxxxxxxx"]
    #   
    # this method returning array of access_token and access_secret
    #
    def authorize_from_request(request_token, request_secret, verifier)
      oauth_request_token = ::OAuth::RequestToken.new(consumer, request_token, request_secret)
      access_token = oauth_request_token.get_access_token(:oauth_verifier => verifier)
      @access_token, @access_secret = access_token.token, access_token.secret
    end
    
    # getting oauth access token
    # 
    def access_token
      @oauth_access_token ||= ::OAuth::AccessToken.new(consumer, @access_token, @access_secret)
    end
    
    private
    # clear request token (for future use)
    # 
    def clear_request_token
      @request_token = nil
    end    
  end
end
