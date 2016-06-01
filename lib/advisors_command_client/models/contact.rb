module AdvisorsCommandClient
  module Models
    class Contact < Base
      attribute :id, Integer
      attribute :name_prefix, String
      attribute :first_name, String
      attribute :middle_name, String
      attribute :last_name, String
      attribute :name_suffix, String
      attribute :gender, String
      attribute :birthday, DateTime
      attribute :email, String
      attribute :created_at, DateTime
      attribute :updated_at, DateTime
      attribute :job_title, String

      attribute :emails, Array[Hash]
      attribute :phones, Array[Hash]
      attribute :addresses, Array[Hash]

      def self.create(params = {})
        # Take params and massage them
        # Post them to /contacts
        # initialize new contact and load resp
        # return new contact
      end

      def full_name
        [name_prefix, first_name, middle_name, last_name, name_suffix].reject(&:blank?).join(' ')
      end

      def accounts
        @accounts ||= @original_hash['accounts'].map do |id|
          resp = @connection.get("accounts/#{id}")
          if resp.success?
            AdvisorsCommandClient::Models::Account.load(resp.body)
          end
        end
      end

      def save
        resp = @connection.put("contacts/#{id}", transform_attributes(attributes))
        puts resp.inspect
        if resp.success?
          underscored_params = self.class.deep_underscore_params(resp)
          self.attributes = underscored_params
          return true
        end

        return false
      end

      private

      def transform_attributes(attributes)
        wrapped_attributes = wrap(attributes)
        wrapped_attributes.to_camelback_keys
      end

      def wrap(attributes)
        { contact: attributes }
      end
    end
  end
end