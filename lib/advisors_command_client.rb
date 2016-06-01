require 'awrence'
require 'virtus'
require "advisors_command_client/version"
require 'advisors_command_client/connection'
require 'advisors_command_client/models/base'
require 'advisors_command_client/models/contact'
require 'advisors_command_client/models/account'
require 'advisors_command_client/models/contact_collection'

module AdvisorsCommandClient
  class SearchError < ::StandardError
  end

  class Client
    TEST_URL = "https://qa.advisorscommand.com/api/rest/latest"
    PROD_URL = "https://advisorscommand.com/api/rest/latest"
    attr_reader :connection

    def initialize(username, api_key, options = {})
      if options[:live]
        url = PROD_URL
      else
        url = TEST_URL
      end
      @connection = AdvisorsCommandClient::Connection.new(username, api_key, url).build
    end

    def contacts
      @contacts ||= Models::ContactCollection.new(connection: @connection)
    end
  end
end
