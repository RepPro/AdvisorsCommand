module AdvisorsCommand
  module Models
    class ContactCollection
      def initialize(args = {})
        @connection = args[:connection]
      end

      def search(query)
        response = @connection.get('search', {search: query, from: 'orocrm_contact'})
        if response.success?
          return Parallel.map(Array(response.body['data']), in_threads: 4) do |obj|
            self.find(obj['record_id'].to_i)
          end.compact
        else
          raise SearchException, "Error connecting to advisors command."
        end
      end

      def find(contact_id)
        resp = @connection.get("contacts/#{contact_id}")
        if resp.success?
          return AdvisorsCommand::Models::Contact.load(resp.body)
        else
          return nil
        end
      end

    end
  end
end