require 'virtus'
require "advisors_command/version"
require 'advisors_command/connection'
require 'advisors_command/models/meek_model'
require 'advisors_command/models/contact'

module AdvisorsCommand
  class Client
    attr_reader :connection

    def initialize(username, api_key)
      @connection = AdvisorsCommand::Connection.new(username, api_key).build
    end

    def search(query)
      @connection.get('search', {search: query})
    end

    def contact(contact_id)
      resp = @connection.get("contacts/#{contact_id}")
      if resp.success?
        return AdvisorsCommand::Models::Contact.load(resp.body)
      else
        return nil
      end
    end
  end
end
