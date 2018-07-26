Rails.application.routes.draw do

	resources :common_users
  get 'common_users/index'
  get 'common_users/add'
  get 'common_users/details'
  devise_for :users
  get 'home/index'
  get 'home/sysadmin'
  get 'home/bizadmin'
  get 'home/useradmin'
	get 'home', to: 'home#index'

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
