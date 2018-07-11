require 'rails_helper'

RSpec.describe RequestsController, type: :controller do

  let(:valid_attributes) { FactoryBot.attributes_for(:request) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:request).except!(:uid) }

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
      get :new, params: {}, session: valid_session
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
          post :create, params: {request: valid_attributes}, session: valid_session
        }.to change(Request, :count).by(1)
      end

      it "redirects to the created request" do
        post :create, params: {request: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Request.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {request: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "POST #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested request" do
        request = Request.create! valid_attributes
        put :update, params: {request_id: request.id, request: new_attributes}, session: valid_session
        request.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the request" do
        request = Request.create! valid_attributes
        put :update, params: {request_id: request.id, request: valid_attributes}, session: valid_session
        expect(response).to redirect_to(request)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        request = Request.create! valid_attributes
        put :update, params: {request_id: request.id, request: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #delete" do
    it "destroys the requested request" do
      request = Request.create! valid_attributes
      expect {
        delete :delete, params: {request_id: request.id}, session: valid_session
      }.to change(Request, :count).by(-1)
    end

    it "redirects to the requests list" do
      request = Request.create! valid_attributes
      delete :delete, params: {request_id: request.id}, session: valid_session
      expect(response).to redirect_to(requests_url)
    end
  end

end
