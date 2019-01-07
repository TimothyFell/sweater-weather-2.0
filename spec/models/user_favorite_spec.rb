require 'rails_helper'

RSpec.describe UserFavorite, type: :model do
  describe 'Relationships' do
    it{should belong_to(:user)}
    it{should belong_to(:favorite)}
  end
end
