require 'rails_helper'

RSpec.describe RequestsController, type: :controller do

  let(:valid_attributes) { FactoryBot.attributes_for(:request) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RequestsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      request = Request.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      request = Request.create! valid_attributes
      get :show, params: {request_id: request.id}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      animal = FactoryBot.create(:animal)
      get :new, params: {animal_id: animal.id}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      request = Request.create! valid_attributes
      get :edit, params: {request_id: request.id}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Request" do
        expect {
          post :create, params: {request_id: 'request_id', request: valid_attributes}, session: valid_session
        }.to change(Request, :count).by(1)
      end

      it "redirects to the index" do
        post :create, params: {request_id: 'request_id', request: valid_attributes}, session: valid_session
        expect(response).to redirect_to(requests_url)
      end
    end
  end

  describe "POST #update" do
    context "with valid params" do
      it "updates the requested request" do
        request = Request.create! valid_attributes
        new_attributes = valid_attributes
        new_attributes[:first_name] = "Moy"

        put :update, params: {request_id: request.id, request: new_attributes}, session: valid_session
        request.reload
        expect(request.first_name).to eq("Moy")
      end

      it "redirects to the index" do
        request = Request.create! valid_attributes
        put :update, params: {request_id: request.id, request: valid_attributes}, session: valid_session
        expect(response).to redirect_to(requests_url)
      end
    end
  end

  describe "change status" do
    it "approves the request" do
      request = Request.create! valid_attributes
      get :approve, params: { request_id: request.id }, session: valid_session
      expect(request.reload.status).to eq('approved')
      expect(response).to redirect_to(requests_url)
    end

    it "rejects the request" do
      request = Request.create! valid_attributes
      get :disapprove, params: { request_id: request.id }, session: valid_session
      expect(request.reload.status).to eq('disapproved')
      expect(response).to redirect_to(requests_url)
    end
  end
end
