require 'rails_helper'

RSpec.describe AnimalsController, type: :controller do
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

    it 'assigns @animals' do
      user = FactoryBot.create(:user)
      sign_in user
      get :index

      animal = FactoryBot.create(:animal)
      expect(assigns(:animals)).to eq([animal])
    end
  end
end
