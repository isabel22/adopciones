# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalBreedsController, type: :controller do
  describe 'index' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }

    it 'does not render the index template' do
      get :index, params: {
        animal_specy_id: animal_specy.id
      }
      expect(response).not_to render_template('index')
    end

    it 'renders the index template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :index, params: {
        animal_specy_id: animal_specy.id
      }
      expect(response).to render_template('index')
    end

    it 'assigns @animal_breeds' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :index, params: {
        animal_specy_id: animal_specy.id
      }

      breeds = FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id)
      expect(assigns(:animal_breeds)).to eq([breeds])
    end
  end

  describe 'new' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }

    it 'does not render the new template' do
      get :new, params: {
        animal_specy_id: animal_specy.id
      }
      expect(response).not_to render_template('new')
    end

    it 'renders the edit template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :new, params: {
        animal_specy_id: animal_specy.id
      }
      expect(response).to render_template('new')
    end
  end

  describe 'create' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }

    it 'does not create an animal breed' do
      expect(AnimalBreed.count).to be(0)
      patch :create, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: 'animal_breed',
        animal_breed: {
          'name' => 'Doggo',
          'animal_specy_id' => animal_specy.id
        }
      }
      expect(AnimalBreed.count).to be(0)
    end

    it 'creates a new animal species' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      expect(AnimalBreed.count).to be(0)
      patch :create, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: 'animal_breed',
        animal_breed: {
          'name' => 'Doggo',
          'animal_specy_id' => animal_specy.id
        }
      }
      expect(AnimalBreed.count).to be(1)
    end
  end

  describe 'show' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }
    let(:animal_breed) { FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id) }

    it 'does not render the show template' do
      get :show, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }
      expect(response).not_to render_template('show')
    end

    it 'renders the show template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :show, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }
      expect(response).to render_template('show')
    end

    it 'assigns @animal_breed' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :show, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }

      expect(assigns(:animal_breed)).to eq(animal_breed)
    end
  end

  describe 'delete' do
    before(:each) do
      @animal_specy = FactoryBot.create(:animal_specy)
      @animal_breed = FactoryBot.create(:animal_breed, animal_specy_id: @animal_specy.id)
    end

    it 'does not remove the animal_specy_id' do
      expect(AnimalBreed.count).to be(1)
      delete :delete, params: {
        animal_specy_id: @animal_specy.id,
        animal_breed_id: @animal_breed.id
      }
      expect(AnimalBreed.count).to be(1)
    end

    it 'destroys the register for animal_specy_id' do
      user = FactoryBot.create(:admin)
      sign_in user

      expect(AnimalBreed.count).to be(1)
      delete :delete, params: {
        animal_specy_id: @animal_specy.id,
        animal_breed_id: @animal_breed.id
      }
      expect(AnimalBreed.count).to be(0)
    end
  end

  describe 'edit' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }
    let(:animal_breed) { FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id) }

    it 'does not render the edit template' do
      get :edit, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }
      expect(response).not_to render_template('edit')
    end

    it 'renders the edit template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :edit, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }
      expect(response).to render_template('edit')
    end

    it 'assigns @animal' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :edit, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id
      }

      expect(assigns(:animal_species)).to eq(animal_specy)
      expect(assigns(:animal_breed)).to eq(animal_breed)
    end
  end

  describe 'update' do
    let(:animal_specy) { FactoryBot.create(:animal_specy) }
    let(:animal_breed) { FactoryBot.create(:animal_breed, animal_specy_id: animal_specy.id) }

    it 'does not update the animal_id' do
      patch :update, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id,
        animal_breed: { 'name' => 'Another breed' }
      }
      expect(animal_breed.reload.name).to match('Breed')
    end

    it 'updates the register for animal_specy_id' do
      user = FactoryBot.create(:admin)
      sign_in user

      patch :update, params: {
        animal_specy_id: animal_specy.id,
        animal_breed_id: animal_breed.id,
        animal_breed: { 'name' => 'Another breed' }
      }
      expect(animal_breed.reload.name).to eq('Another breed')
    end
  end
end
