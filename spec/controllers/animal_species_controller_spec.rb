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

  describe 'new' do
    it "does not render the new template" do
      get :new
      expect(response).not_to render_template("new")
    end

    it "renders the edit template" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'create' do
    it 'does not create an animal species' do
      expect(AnimalSpecy.count).to be(0)
      patch :create, :params => {
        animal_specy_id: "animal_specy",
        animal_specy: {
          "name"=>"Mammal"
        }
      }
      expect(AnimalSpecy.count).to be(0)
    end

    it 'creates a new animal species' do
      user = FactoryBot.create(:user)
      sign_in user

      expect(AnimalSpecy.count).to be(0)
      patch :create, :params => {
        animal_specy_id: "animal_specy",
        animal_specy: {
          "name"=>"Mammal"
        }
      }
      expect(AnimalSpecy.count).to be(1)
    end
  end

  describe 'show' do
    let(:animal_specy) {FactoryBot.create(:animal_specy)}

    it "does not render the show template" do
      get :show, :params => {animal_specy_id: animal_specy.id}
      expect(response).not_to render_template("show")
    end

    it "renders the show template" do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, :params => {animal_specy_id: animal_specy.id}
      expect(response).to render_template("show")
    end

    it 'assigns @animal_species' do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, :params => {animal_specy_id: animal_specy.id}

      expect(assigns(:animal_species)).to eq(animal_specy)
    end
  end

  describe 'edit' do
    let(:animal_specy) {FactoryBot.create(:animal_specy)}

    it "does not render the edit template" do
      get :edit, :params => {animal_specy_id: animal_specy.id}
      expect(response).not_to render_template("edit")
    end

    it "renders the edit template" do
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, :params => {animal_specy_id: animal_specy.id}
      expect(response).to render_template("edit")
    end

    it 'assigns @animal' do
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, :params => {animal_specy_id: animal_specy.id}

      expect(assigns(:animal_species)).to eq(animal_specy)
    end
  end

  describe 'update' do
    let(:animal_specy) {FactoryBot.create(:animal_specy)}

    it 'does not update the animal_id' do
      patch :update, :params => {animal_specy_id: animal_specy.id, animal_specy: {"name"=>"Mammal"}}
      expect(animal_specy.reload.name).to match('Dog')
    end

    it 'updates the register for animal_specy_id' do
      user = FactoryBot.create(:user)
      sign_in user

      patch :update, :params => {animal_specy_id: animal_specy.id, animal_specy: {"name"=>"Mammal"}}
      expect(animal_specy.reload.name).to eq('Mammal')
    end
  end

  describe 'delete' do
    before(:each) do
      @animal_specy = FactoryBot.create(:animal_specy)
    end

    it 'does not remove the animal_specy_id' do
      expect(AnimalSpecy.count).to be(1)
      delete :delete, :params => {animal_specy_id: @animal_specy.id}
      expect(AnimalSpecy.count).to be(1)
    end

    it 'destroys the register for animal_specy_id' do
      user = FactoryBot.create(:user)
      sign_in user

      expect(AnimalSpecy.count).to be(1)
      delete :delete, :params => {animal_specy_id: @animal_specy.id}
      expect(AnimalSpecy.count).to be(0)
    end
  end
end
