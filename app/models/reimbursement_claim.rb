class ReimbursementClaim < ApplicationRecord
  belongs_to :user
  has_one_attached :receipt # Use ActiveStorage for file uploads

  # Validations
  validates :purpose, presence: true, length: { minimum: 4 }
  validates :amount, presence: true, numericality: { greater_than: 0.01 }
end