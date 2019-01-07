class Favorite < ApplicationRecord
  validates :location, presence: true, uniqueness: true

  has_many :user_favorites
  has_many :users, through: :user_favorites
end
