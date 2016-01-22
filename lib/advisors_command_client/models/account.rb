module AdvisorsCommandClient
  module Models
    class Account < Base
      attribute :id, Integer
      attribute :contact, AdvisorsCommandClient::Models::Contact
      attribute :ssn_tax_id, String
      attribute :drivers_license, String
      attribute :drivers_license_expiration_date, DateTime
      attribute :drivers_license_issue_date, DateTime
      attribute :drivers_license_issue_state, String
      attribute :passport_number, String
      attribute :income, Float
      attribute :net_worth, Float
      attribute :savings, Float
      attribute :ira401k, Float
      attribute :monthly_salary, Float
      attribute :monthly_expense, Float
      attribute :salary_increase_percent, Integer

      attribute :retirement_age, Integer
      attribute :marital_status, String
    end
  end
end