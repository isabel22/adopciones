# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'adoptions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :animals, only: %i[index new] do
    get :show
    delete :delete
    get :edit
    patch :update
    post :create
  end

  resources :animal_species, only: %i[index new] do
    post :create
    get :show
    get :edit
    patch :update
    delete :delete

    resources :animal_breeds, only: %i[index new] do
      post :create
      get :show
      delete :delete
      get :edit
      patch :update
    end
  end

  resources :requests, only: %i[index new edit] do
    post :create
    get :show
    get :edit
    post :update
    get :approve
    get :disapprove
  end

  resources :associations, only: [:show]
end
