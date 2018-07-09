Rails.application.routes.draw do
  get 'common_users/index'
  get 'common_users/add'
  get 'common_users/details'
  get 'common_userindex/add'
  get 'common_userindex/details'
  devise_for :users
  get 'home/index'
  get 'home/sysadmin'
  get 'home/bizadmin'
  get 'home/rendertext'

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
