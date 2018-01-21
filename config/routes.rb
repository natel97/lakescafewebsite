Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'sections#index'

  resources :sections
  resources :items, defaults: { format: :json }
  resources :headings, defaults: { format: :json }
  resources :sub_items, defaults: { format: :json }
  get 'onepage', to: 'headings#index'
  put 'admin/set-soup', to: 'soups#set_soups'
  put 'admin/alter-variables', to: 'soups#set_variables'
  put 'admin/google_drive', to: 'soups#google_drive'
  put 'admin/update-menu', to: 'items#update_menu'
  put 'admin/update-images', to: 'headings#update_images'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
