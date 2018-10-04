# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalBreedsController, type: :controller do
  describe 'index' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }

    def load_index
      get :index, params: {
        animal_specy_id: animal_specy.id
      }
    end

    it 'does not render the index template' do
      load_index
      expect(response).not_to render_template('index')
    end

    it 'renders the index template' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      load_index
      expect(response).to render_template('index')
    end

    it 'assigns @animal_breeds' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      load_index
      breeds = FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id)
      expect(assigns(:animal_breeds)).to eq([breeds])
    end
  end

  describe 'new' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }

    def new_breed
      get :new, params: {
        animal_specy_id: animal_specy.id
      }
    end

    it 'does not render the new template' do
      new_breed
      expect(response).not_to render_template('new')
    end

    it 'renders the edit template' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      new_breed
      expect(response).to render_template('new')
    end
  end

  describe 'create' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }

    def create_breed
      patch :create, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: 'animal_breed',
        animal_breed: {
          'name' => 'Doggo',
          'animal_specy_id' => animal_specy.id
        }
      }
    end

    it 'does not create an animal breed' do
      expect(AnimalBreed.count).to be(0)
      create_breed
      expect(AnimalBreed.count).to be(0)
    end

    it 'creates a new animal species' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      expect(AnimalBreed.count).to be(0)
      create_breed
      expect(AnimalBreed.count).to be(1)
    end
  end

  describe 'show' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }
    let(:animal_breed) { FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id) }

    def show_breed
      get :show, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }
    end

    it 'does not render the show template' do
      show_breed
      expect(response).not_to render_template('show')
    end

    it 'renders the show template' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      show_breed
      expect(response).to render_template('show')
    end

    it 'assigns @animal_breed' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      show_breed
      expect(assigns(:animal_breed)).to eq(animal_breed)
    end
  end

  describe 'delete' do
    before do
      animal_specy = FactoryBot.create(:animal_specy)
      FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id)
    end

    def delete_breed
      delete :delete, params: {
        animal_specy_id: AnimalSpecy.first.id,
        animal_breed_id: AnimalBreed.first.id
      }
    end

    it 'does not remove the animal_specy_id' do
      expect(AnimalBreed.count).to be(1)
      delete_breed
      expect(AnimalBreed.count).to be(1)
    end

    it 'destroys the register for animal_specy_id' do
      user = FactoryBot.create(:admin)
      sign_in user

      expect(AnimalBreed.count).to be(1)
      delete_breed
      expect(AnimalBreed.count).to be(0)
    end
  end

  describe 'edit' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }
    let(:animal_breed) { FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id) }

    def edit_breed
      get :edit, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }
    end

    it 'does not render the edit template' do
      edit_breed
      expect(response).not_to render_template('edit')
    end

    it 'renders the edit template' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      edit_breed
      expect(response).to render_template('edit')
    end

    it 'assigns @animal' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      edit_breed
      expect(assigns(:animal_species)).to eq(animal_specy)
      expect(assigns(:animal_breed)).to eq(animal_breed)
    end
  end

  describe 'update' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }
    let(:animal_breed) { FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id) }

    def update_breed
      patch :update, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id,
        animal_breed: { 'name' => 'Another breed' }
      }
    end

    it 'does not update the animal_id' do
      update_breed
      expect(animal_breed.reload.name).to match('Breed')
    end

    it 'updates the register for animal_specy_id' do
      user = FactoryBot.create(:admin)
      sign_in user

      update_breed
      expect(animal_breed.reload.name).to eq('Another breed')
    end
  end
end
