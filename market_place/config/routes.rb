Rails.application.routes.draw do

  get 'products/index'
  get 'products/new'
  get 'products/create'
  get 'products/show'
  get 'products/edit'
  get 'products/delete'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'store/index'
  get 'store/new'
  get 'store/create'
  get 'store/show'
  get 'store/edit'
  get 'store/delete'
  devise_for :stores
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
