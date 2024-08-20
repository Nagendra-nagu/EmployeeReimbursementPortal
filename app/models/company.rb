class Company < ApplicationRecord
    has_many :users
    has_many :reimbursement_claims, through: :employees

    def employee_count
        users.count
    end

    def sum_reimbursement_claims
        users.joins(:reimbursement_claims).sum(:amount)
    end
end