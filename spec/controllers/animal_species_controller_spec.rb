require 'rails_helper'

RSpec.describe AnimalSpeciesController, type: :controller do
  describe 'index' do
    it "does not render the index template" do
      get :index
      expect(response).not_to render_template("index")
    end

    it "renders the index template" do
      user = FactoryBot.create(:user)
      sign_in user
      get :index
      expect(response).to render_template("index")
    end

    it 'assigns @animal_species' do
      user = FactoryBot.create(:user)
      sign_in user
      get :index

      species = FactoryBot.create(:animal_specy)
      expect(assigns(:animal_species)).to eq([species])
    end
  end
end
