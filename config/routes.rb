Rails.application.routes.draw do
  resources :sub_items
  resources :items
  resources :sections
  resources :headings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
