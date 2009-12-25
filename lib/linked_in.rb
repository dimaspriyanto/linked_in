# LinkedIn API Interface for Rails
#

require 'rubygems'
require 'oauth'

module LinkedIn
  class LinkedInError < StandardError
    attr_reader :data
    
    def initialize(data)
      @data = data
      super
    end
  end
end

require 'linked_in/base'
require 'linked_in/oauth'
require 'linked_in/consumer'
require 'linked_in/request'
require 'linked_in/client'