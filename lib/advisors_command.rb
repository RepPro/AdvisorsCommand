require 'virtus'
require "advisors_command/version"
require 'advisors_command/connection'
require 'advisors_command/models/meek_model'
require 'advisors_command/models/contact'
require 'advisors_command/models/contact_collection'

module AdvisorsCommandClient
  class SearchError < ::StandardError
  end

  class Client
    attr_reader :connection

    def initialize(username, api_key)
      @connection = AdvisorsCommandClient::Connection.new(username, api_key).build
    end

    def contacts
      @contacts ||= Models::ContactCollection.new(connection: @connection)
    end
  end
end
