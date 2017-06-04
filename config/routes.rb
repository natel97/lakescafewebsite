Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'headings#index'
  
  resources :sub_items
  resources :items
  resources :sections
  resources :headings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
