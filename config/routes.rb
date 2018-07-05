Rails.application.routes.draw do
  devise_for :users
  root to: 'root#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :animals, only: [:index, :new] do
    get :show
    delete :delete
    get :edit
    patch :update
    post :create
  end

  resources :animal_species, only: [:index]
end
