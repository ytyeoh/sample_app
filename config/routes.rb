Rails.application.routes.draw do

  resources :favorite_listings, only: [:create, :destroy]
  resources :user_credits, only: [:new, :index]
  resources :listings do 
    collection do
      post :import
      get :autocomplete, :owner # <= add this line
    end
  end
  
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions"}
  resources :users do 
    resources :reviews
  end

  post '/rate' => 'rater#create', :as => 'rate'
  post '/credits/checkout' => 'user_credits#create'
 
  root 'home#index'

end
