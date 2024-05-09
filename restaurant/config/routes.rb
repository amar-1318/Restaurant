Rails.application.routes.draw do
  root to: redirect("/users/sign_in")
  get "users_signup/new"
  get "users_signup/create"
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :orders do
    collection do
      post "/orders", to: "orders#create", as: "create_order"
    end
  end

  resources :menus do
    collection do
      get "item_type_menu"
      get "/new", to: "menus#new", as: :new_menu
      post "/", to: "menus#create", as: :create_menu
      get "/search", to: "menus#search"
    end
  end

  resources :carts do
    collection do
      post "/add_cart_items/:id", to: "carts#add_cart_items"
      put "/cart/update/", to: "carts#update"
    end
  end

  resources :ratings do
    collection do
    end
  end

  resources :restaurant_details do
    collection do
      get "/menus/:id", to: "restaurant_details#restaurant_menu", as: :restaurant_menu
      get "/new", to: "restaurant_details#new", as: :new_restaurant_detail
      post "/", to: "restaurant_details#create", as: :create_restaurant_detail
      get "/edit", to: "restaurant_details#edit"
    end
  end

  resources :users do
    collection do
      get "/customer_dashboard", to: "users#customer_dashboard", as: :customer_dashboard
      get "/owner_dashboard", to: "users#owner_dashboard"
    end
  end
  namespace :admin do
    resources :admins do
      collection do
        get "customers", to: "admins#customers"
        get "owners", to: "admins#owners"
        get "restaurants", to: "admins#restaurants"
      end
    end
  end
end
