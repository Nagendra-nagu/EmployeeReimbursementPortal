class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Add enum for role
  enum role: { user: 0, admin: 1, employee: 2 }

  # Associations
  belongs_to :company, optional: true
  has_many :reimbursement_claims

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.remote_avatar_url = auth.info.image
    end
  end
end
