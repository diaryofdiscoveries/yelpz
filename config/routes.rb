Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :restaurants

  root 'welcome#index'
end
