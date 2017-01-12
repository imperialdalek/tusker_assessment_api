Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :prospects, :only => [ :index] , :defaults => { :format => :json }
resources :packages,  :only => [ :index, :next_delivery, :delivery_cities] , :defaults => { :format => :json }
# get "/prospects" => "prospects#index" , :as => :prospects

get "/packages/next_delivery/" => "packages#next_delivery" , :as => :next_delivery
get "/packages/delivery_cities/" => "packages#delivery_cities" , :as => :delivery_cities


root "prospects#index"

end
