Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :animals, only: [:index, :new] do
    get :show
    delete :delete
    get :edit
    patch :update
    post :create
  end
end
