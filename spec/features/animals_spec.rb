require 'rails_helper'

RSpec.feature "Animals", type: :feature do
  describe :index do
    it 'can visit the index', js: true do
      login_as FactoryBot.create(:user)
      visit animals_path
      expect(page).to have_content("Animals")
    end

    it 'does not have permissions to visit the index' do
      visit animals_path
      expect(page).not_to have_content("Animals")
    end
  end
end
