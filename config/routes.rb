Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  get 'search', to: 'tweets#search'
end
