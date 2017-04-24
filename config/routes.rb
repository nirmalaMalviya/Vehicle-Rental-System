Rails.application.routes.draw do
  resources :my_admins
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: "registrations" }
  resources :welcomes
  resources :book_vehicles do
  	collection do 
  		get 'payment'
  		post 'stripe_payment'
      get 'jquerywork'
  	end
  end

  resources :vehicles do
  	collection do 
  		post 'vehicleposts'
  	end
  end

  resources :friend_requests do
  	member do
  		patch 'confirm_friend'
  	end

    member do
  		delete 'delete_friend'
  	end

  end

  resources :users do
  	member do
      patch 'add_showing_image'
    end

    member do
      get 'show_friend_request'
    end

    collection do
    	get 'userposts'
    end
  end
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  root to: "vehicles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


