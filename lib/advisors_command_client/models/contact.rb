module AdvisorsCommandClient
  module Models
    class Contact < Base
      attribute :id, Integer
      attribute :nickname, String
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
      attribute :employer, String
      attribute :job_title, String

      attribute :emails, Array[Hash]
      attribute :phones, Array[Hash]
      attribute :addresses, Array[Hash]


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
    end
  end
end