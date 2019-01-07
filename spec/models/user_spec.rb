require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
  end

  describe 'Relationships' do
    it{should have_many(:user_favorites)}
    it{should have_many(:favorites)}
  end
end
