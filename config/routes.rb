Rails.application.routes.draw do

  resources :skill_connects
  get 'privilege/assign_role'
  get 'projects/index'
  get 'projects/new'
  get 'projects/detail'
  get 'properties/index'
  get 'properties/new'


  get 'office/index', to: 'office#index'
  post 'office/index(.:format)', to: 'office#index'
  get 'office/list', to: 'office#list'
  get 'office/new'
  post 'office/new(.:format)', to: 'office#new'
  patch 'office/update(.:format)', to: 'office#update'
  get 'office/:id', to: 'office#edit'

  get 'common_users/index'
  get 'common_users/add'
  get 'common_users/details'
  get 'common_users/assign_role'
  get 'common_users/new'
  post 'common_users/priv_update'

  resources :engineer
  post 'engineer/search'
  resources :business
  get 'business/index'
  get 'business/new'
  post 'business/new'
  get 'business/edit'
  get 'business/edit_own'
  get 'business/contact_list'
  post 'business/search'
  resources :staff
  resources :offer
  resources :proposal

  get 'grid', to: 'grid#index'
  get 'grid/index'
  get 'grid/view/:action_name', to:'grid#view'

  devise_for :users
  get 'home/index'
  get 'home/sysadmin'
  get 'home/bizadmin'
  get 'home/user'
  get 'home', to: 'home#index'

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
