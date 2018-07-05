require 'rails_helper'

RSpec.describe AnimalBreedsController, type: :controller do
  describe 'index' do
    let(:animal_specy) {FactoryBot.create(:animal_specy)}

    it "does not render the index template" do
      get :index, :params => {
        animal_specy_id: animal_specy.id
      }
      expect(response).not_to render_template("index")
    end

    it "renders the index template" do
      user = FactoryBot.create(:user)
      sign_in user
      get :index, :params => {
        animal_specy_id: animal_specy.id
      }
      expect(response).to render_template("index")
    end

    it 'assigns @animal_breeds' do
      user = FactoryBot.create(:user)
      sign_in user
      get :index, :params => {
        animal_specy_id: animal_specy.id
      }

      breeds = FactoryBot.create(:animal_breed, animal_species_id: animal_specy.id)
      expect(assigns(:animal_breeds)).to eq([breeds])
    end
  end
end
