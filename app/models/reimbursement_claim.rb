class ReimbursementClaim < ApplicationRecord
  belongs_to :user
  has_one_attached :receipt # Use ActiveStorage for file uploads
end