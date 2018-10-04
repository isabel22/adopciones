# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  let(:valid_attributes) { FactoryBot.attributes_for(:request) }

  describe 'GET #index' do
    before(:each) do
      user = FactoryBot.create(:requester)
      sign_in user
    end

    it 'returns a success response' do
      Request.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    before(:each) do
      user = FactoryBot.create(:volunteer)
      sign_in user
    end

    it 'returns a success response' do
      request = Request.create! valid_attributes
      get :show, params: { request_id: request.id }
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    before(:each) do
      user = FactoryBot.create(:requester)
      sign_in user
    end

    it 'returns a success response' do
      animal = FactoryBot.create(:animal)
      get :new, params: { animal_id: animal.id }
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    before(:each) do
      user = FactoryBot.create(:requester)
      sign_in user
    end

    it 'returns a success response' do
      request = Request.create! valid_attributes
      get :edit, params: { request_id: request.id }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    before(:each) do
      user = FactoryBot.create(:requester)
      sign_in user
    end

    context 'with valid params' do
      it 'creates a new Request' do
        expect do
          post :create, params: { request_id: 'request_id', request: valid_attributes }
        end.to change(Request, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: { request_id: 'request_id', request: valid_attributes }
        expect(response).to redirect_to(requests_url)
      end
    end
  end

  describe 'POST #update' do
    before(:each) do
      user = FactoryBot.create(:requester)
      sign_in user
    end

    context 'with valid params' do
      it 'updates the requested request' do
        request = Request.create! valid_attributes
        new_attributes = valid_attributes
        new_attributes[:first_name] = 'Moy'

        put :update, params: { request_id: request.id, request: new_attributes }
        request.reload
        expect(request.first_name).to eq('Moy')
      end

      it 'redirects to the index' do
        request = Request.create! valid_attributes
        put :update, params: { request_id: request.id, request: valid_attributes }
        expect(response).to redirect_to(requests_url)
      end
    end
  end

  describe 'change status' do
    before(:each) do
      user = FactoryBot.create(:volunteer)
      sign_in user
    end

    it 'approves the request' do
      request = Request.create! valid_attributes
      get :approve, params: { request_id: request.id }
      expect(request.reload.status).to eq('approved')
      expect(response).to redirect_to(requests_url)
    end

    it 'rejects the request' do
      request = Request.create! valid_attributes
      get :disapprove, params: { request_id: request.id }
      expect(request.reload.status).to eq('disapproved')
      expect(response).to redirect_to(requests_url)
    end
  end
end
