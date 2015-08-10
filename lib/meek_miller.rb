require 'virtus'
require "meek_miller/version"
require 'meek_miller/connection'
require 'meek_miller/models/meek_model'
require 'meek_miller/models/contact'

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
      resp = @connection.get("contacts/#{contact_id}")
      if resp.success?
        return MeekMiller::Models::Contact.load(resp.body)
      else
        return nil
      end
    end
  end
end
