Rails.application.routes.draw do
  get 'welcome/index'

  resources :restaurants

  root 'welcome#index'
end
