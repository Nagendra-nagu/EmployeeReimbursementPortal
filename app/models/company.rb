class Company < ApplicationRecord
    has_many :users
    has_many :reimbursement_claims, through: :employees

    validates :name, presence: true, length: { minimum: 2, maximum: 100 }

    def employee_count
        users.count
    end

    def sum_reimbursement_claims
        users.joins(:reimbursement_claims).sum(:amount)
    end
end