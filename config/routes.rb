Rails.application.routes.draw do

	resources :skill_connects
	get 'privilege/assign_role'
	get 'projects/index'
	get 'projects/new'
	get 'projects/detail'
	get 'properties/index'
	get 'properties/new'

	get 'businesses/index'
	get 'businesses/new'
	post 'businesses/new'
	get 'businesses/edit'
	get 'businesses/edit_own'
	get 'businesses/contact_list'

	get 'office/index', to: 'office#index'
	post 'office/index(.:format)', to: 'office#index'
	get 'office/list', to: 'office#list'
	get 'office/new'
	post 'office/new(.:format)', to: 'office#new'
	get 'office/:id', to: 'office#edit'

	resources :common_users
	get 'common_users/index'
	get 'common_users/add'
	get 'common_users/details'
	get 'common_users/assign_role'

	resources :engineer
	resources :business
	resources :staff
	resources :offer
	resources :proposal

	devise_for :users
	get 'home/index'
	get 'home/sysadmin'
	get 'home/bizadmin'
	get 'home/useradmin'
	get 'home', to: 'home#index'

	root to: 'home#index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
