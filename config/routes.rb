Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'sections#index'
  
  resources :sections
  resources :items, :defaults => { :format => :json}
  resources :headings, :defaults => {:format => :json}
  resources :sub_items, :defaults => {:format => :json}
  get 'onepage', to: 'headings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
