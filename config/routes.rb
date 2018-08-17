Rails.application.routes.draw do

	get 'privilege/assign_role'
	get 'projects/index'
	get 'projects/new'
	get 'projects/detail'
	get 'properties/index'
	get 'properties/new'

	get 'businesses/index'
	get 'businesses/new'
	get 'businesses/edit_own'
	get 'businesses/contact_list'

	get 'office/index'
	get 'office/new'
	get 'office/edit'

	resources :common_users
	get 'common_users/index'
	get 'common_users/add'
	get 'common_users/details'
	get 'common_users/assign_role'

	devise_for :users
	get 'home/index'
	get 'home/sysadmin'
	get 'home/bizadmin'
	get 'home/useradmin'
	get 'home', to: 'home#index'

	root to: 'home#index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
