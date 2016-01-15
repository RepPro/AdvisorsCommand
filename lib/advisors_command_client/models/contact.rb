module AdvisorsCommandClient
  module Models
    class Contact < Base
      attribute :id, Integer
      attribute :nickname, String
      attribute :first_name, String
      attribute :middle_name, String
      attribute :last_name, String
      attribute :gender
      attribute :birthday
      attribute :created_at, DateTime
      attribute :updated_at, DateTime

      attribute :emails, Array[String]
      attribute :phones, Array[String]


      def full_name
        [first_name, middle_name, last_name].compact.join(' ')
      end
    end
  end
end