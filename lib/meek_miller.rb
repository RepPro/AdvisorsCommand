require "meek_miller/version"
require 'meek_miller/connection'

module MeekMiller
  class Client
    attr_reader :connection

    def initialize(username, api_key)
      @connection = MeekMiller::Connection.new(username, api_key).build
    end

    def search(query)
      @connection.get('search', {search: query})
    end

    def contact(contact_id)
      @connection.get("contacts/#{contact_id}")
    end
  end
end
