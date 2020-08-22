# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalsController, type: :controller do
  describe 'index' do
    it 'does not render the index template' do
      get :index
      expect(response).not_to render_template('index')
    end

    it 'renders the index template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns @animals' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :index

      animal = FactoryBot.create(:animal)
      expect(assigns(:animals)).to eq([animal])
    end
  end

  describe 'show' do
    let(:animal) { FactoryBot.create(:animal) }

    it 'does not render the show template' do
      get :show, params: { animal_id: animal.id }
      expect(response).not_to render_template('show')
    end

    it 'renders the show template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :show, params: { animal_id: animal.id }
      expect(response).to render_template('show')
    end

    it 'assigns @animal' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :show, params: { animal_id: animal.id }

      expect(assigns(:animal)).to eq(animal)
    end
  end

  describe 'delete' do
    before do
      FactoryBot.create(:animal)
    end

    it 'does not remove the animal_id' do
      expect(Animal.count).to be(1)
      delete :delete, params: { animal_id: Animal.first.id }
      expect(Animal.count).to be(1)
    end

    it 'destroys the register for animal_id' do
      user = FactoryBot.create(:admin)
      sign_in user

      expect(Animal.count).to be(1)
      delete :delete, params: { animal_id: Animal.first.id }
      expect(Animal.count).to be(0)
    end
  end

  describe 'edit' do
    let(:animal) { FactoryBot.create(:animal) }

    it 'does not render the edit template' do
      get :edit, params: { animal_id: animal.id }
      expect(response).not_to render_template('edit')
    end

    it 'renders the edit template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :edit, params: { animal_id: animal.id }
      expect(response).to render_template('edit')
    end

    it 'assigns @animal' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :edit, params: { animal_id: animal.id }

      expect(assigns(:animal)).to eq(animal)
    end
  end

  describe 'update' do
    let(:animal) { FactoryBot.create(:animal) }

    it 'does not update the animal_id' do
      patch :update, params: { animal_id: animal.id, animal: { 'name' => 'Maggie' } }
      expect(animal.reload.name).to match('Firulais')
    end

    it 'updates the register for animal_id' do
      user = FactoryBot.create(:volunteer)
      sign_in user

      patch :update, params: { animal_id: animal.id, animal: { 'name' => 'Maggie' } }
      expect(animal.reload.name).to eq('Maggie')
    end
  end

  describe 'new' do
    it 'does not render the new template' do
      get :new
      expect(response).not_to render_template('new')
    end

    it 'renders the edit template' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :new
      expect(response).to render_template('new')
    end

    it 'assigns @animal_species and @animal_breeds' do
      user = FactoryBot.create(:volunteer)
      sign_in user
      get :new

      expect(assigns(:animal_species)).to eq(AnimalSpecy.all)
      expect(assigns(:animal_breeds)).to eq(AnimalBreed.all)
    end
  end

  describe 'create' do
    before do
      sign_in FactoryBot.create(:volunteer)
    end

    def create_animal(profile_picture: nil, rescued: nil, adopted: nil)
      patch :create, params: {
        animal_id: 'animal',
        animal: {
          'name' => 'Maggie', 'gender' => 'female', 'birthdate_rescuedate' => Date.today,
          'profile_picture' => profile_picture, 'rescued' => rescued,
          'animal_breeds_id' => FactoryBot.create(:animal_breed).id, 'adopted' => adopted
        }
      }
    end

    it 'does not create an animal' do
      expect { create_animal }.not_to change(Animal, :count)
    end

    it 'creates a new animal' do
      expect do
        create_animal(
          profile_picture: 'http://test.com/test.png', rescued: true, adopted: false
        )
      end.to change { Animal.all.size }.by(1)
    end
  end
end
