Rails.application.routes.draw do

  
  resources :user_credits, only: [:new, :index]
  resources :listings

  devise_for :users
  resources :users do 
    resources :reviews
  end

  post '/rate' => 'rater#create', :as => 'rate'
  post '/credits/checkout' => 'user_credits#create'
 
  root 'home#index'

end
