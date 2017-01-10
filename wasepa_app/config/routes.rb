Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#  namespace 'api', :module => 'api' do
#    get    'json'       => 'json#insert'
  namespace :api, { format: 'json' } do
    resources :json
    get 'json/insert'
  end
end
