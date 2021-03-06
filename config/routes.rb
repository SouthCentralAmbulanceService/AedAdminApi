Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: redirect('http://www.scas.nhs.uk')
  namespace :api do
    get '/aed_data', to: 'aed_manager#aed_data'
    get '/aed_data_geo', to: 'aed_manager#aed_data_geo'
  end
end
