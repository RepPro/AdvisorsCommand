module AdvisorsCommandClient
  module Models
    class Contact < Base
      attribute :id, Integer
      attribute :nickname, String
      attribute :first_name, String
      attribute :middle_name, String
      attribute :last_name, String
      attribute :gender, String
      attribute :birthday, DateTime
      attribute :email, String
      attribute :created_at, DateTime
      attribute :updated_at, DateTime

      attribute :emails, Array[Hash]
      attribute :phones, Array[Hash]
      attribute :addresses, Array[Hash]


      def full_name
        [first_name, middle_name, last_name].compact.join(' ')
      end
    end
  end
end