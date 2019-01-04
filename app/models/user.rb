class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation:true

  def self.user_create(params)
    stuff = params.to_h
    stuff["api_key"] = SecureRandom.uuid
    User.create(stuff)
  end

  has_secure_password
end
