Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  namespace :user_block do 
    post '/sign_up', to: 'users#sign_up'
    post '/sign_in', to: 'users#sign_in'
    get '/country_code_with_flag', to: 'users#country_code_with_flag'
  end

  namespace :property_block do 
    resources :properties do 
      collection do 
        get 'owner_property'
        get 'current_user_booked_property'
      end

    end
  end

  namespace :order_block do 
    resources :orders do 
      collection do 
        get 'current_user_order'
      end
    end
  end

  namespace :follow_block do 
    post '/follow', to: 'followers#follow'
    get '/following_list', to: 'followers#following_list'
    get '/follower_list', to:'followers#follower_list'
    delete '/unfollow', to:'followers#unfollow'
  end

  namespace :favorite_block do 
    resources :favorites
  end

  namespace :rating_block do 
    resources :ratings
  end

  namespace :password_block do 
    post 'reset_password', to: 'reset_password#reset_password'
    post 'verify_otp', to: 'reset_password#verify_otp'
    post 'update_password', to: 'reset_password#update_password'
    post 'change_password', to: 'reset_password#change_password'
  end
end
