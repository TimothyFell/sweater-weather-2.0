require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'Validations' do
    it{should validate_presence_of :location}
    it{should validate_uniqueness_of :location}

  end

  describe 'Relationships' do
    it{should have_many(:user_favorites)}
    it{should have_many(:users)}
  end
end
