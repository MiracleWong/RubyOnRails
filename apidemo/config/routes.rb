Rails.application.routes.draw do
  get 'say/hello'
  get 'say/login'
  resources :users, only: [:index, :create, :show, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
