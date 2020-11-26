class User < ApplicationRecord
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  has_many :contributions, dependent: :destroy
  has_many :comments, dependent: :destroy
  
    def self.from_omniauth(auth)
    #Creates a new user only if it doesn't exist
        where(email: auth.info.email).first_or_initialize do |user|
          user.username = auth.info.name
          user.email = auth.info.email
          user.auth_token = auth.credentials.token
          user.Karma = SecureRandom.hex
        end
    end
end
