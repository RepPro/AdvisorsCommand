require 'virtus'
require "advisors_command_client/version"
require 'advisors_command_client/connection'
require 'advisors_command_client/models/client'
require 'advisors_command_client/models/contact'
require 'advisors_command_client/models/contact_collection'

module AdvisorsCommandClient
  class SearchError < ::StandardError
  end

  class Client
    TEST_URL = "https://qa.advisorscommand.com/api/rest/v1"
    attr_reader :connection

    def initialize(username, api_key, url = nil)
      url ||= TEST_URL
      @connection = AdvisorsCommandClient::Connection.new(username, api_key, url).build
    end

    def contacts
      @contacts ||= Models::ContactCollection.new(connection: @connection)
    end
  end
end
