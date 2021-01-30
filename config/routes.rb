Rails.application.routes.draw do
  resources :tokens, only: [:create]
  resources :users, only: [:create]

  get  '/balance/:account_id', to: 'accounts#balance'
  post 'accounts/transfer', to: 'accounts#transfer'

  resources :accounts, only: [:create]
end