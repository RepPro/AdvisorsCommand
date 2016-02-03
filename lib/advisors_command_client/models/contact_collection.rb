module AdvisorsCommandClient
  module Models
    class ContactCollection
      def initialize(args = {})
        @connection = args[:connection]
      end

      def search(query)
        response = @connection.get('search', {search: query, from: 'orocrm_contact'})
        if response.success?
          return Parallel.map(Array(response.body['data'])) do |obj|
            begin
              next unless obj['record_string'].present?
              self.find(obj['record_id'].to_i)
            rescue Faraday::Error::ParsingError
              puts "Error parsing response for contact ID: #{obj['record_id']}"
              next nil
            end
          end.compact
        else
          raise ::AdvisorsCommandClient::SearchError, "Error connecting to advisors command."
        end
      end

      def find(contact_id)
        resp = @connection.get("contacts/#{contact_id}")
        if resp.success?
          return AdvisorsCommandClient::Models::Contact.load(resp.body, @connection)
        else
          return nil
        end
      end

    end
  end
end