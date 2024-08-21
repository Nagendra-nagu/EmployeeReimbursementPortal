class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: { user: 0, admin: 1, employee: 2 }

  belongs_to :company, optional: true
  has_many :reimbursement_claims

  validates :fname, presence: true, length: { minimum: 2, maximum: 50 }
  validates :lname, length: { minimum: 2, maximum: 50 }, allow_blank: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def self.from_omniauth(auth)
    # Attempt to find the user by provider and uid
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    
    # If no user is found, check if a user exists with the given email
    unless user
      user = User.find_by(email: auth.info.email.downcase)
      if user
        # Update user details from the OAuth data
        user.provider = auth.provider
        user.uid = auth.uid
        user.fname = auth.info.first_name
        user.lname = auth.info.last_name
        user.email = auth.info.email
        user.save
      end
    end
  
    user
  end
  
end
