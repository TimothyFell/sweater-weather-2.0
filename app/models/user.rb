class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation:true

  def self.user_create(params)
    stuff = {}
    stuff[:email] = params["email"]
    stuff[:password] = params["password"]
    stuff[:password_confirmation] = params["password_confirmation"]
    stuff[:api_key] = SecureRandom.uuid
    User.create(stuff)
  end

  has_secure_password
end
