Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'invoke_lambda' => 'home#invoke_lambda'
  get 'create' => 'home#create'
  get 'show' => 'home#show'
  get 'destroy' => 'home#destroy'
end
