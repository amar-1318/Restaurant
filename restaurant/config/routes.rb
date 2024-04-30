Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "user#index"
  get "/restaurant_detail/max_rating", to: "restaurant_detail#max_avg_rating"
  get "/restaurant/find", to: "restaurant_detail#find"
  get "/restaurant/view_restaurants", to: "restaurant_detail#view_restaurants"
  get "/restaurant/menu", to: "menu#display_restaunt_menu"
  get "/restaurant/menu/count", to: "restaurant_detail#ordered_count"

  get "/menu/item_type/", to: "menu#display_menu_of_item_type"
  get "/menu/types", to: "menu#display_types"
  get "/menu/search_by_menu_name", to: "menu#search_by_menu_name"

  get "/cart/pending_cart", to: "cart#pending_cart_worth_1000"
  post "/cart/add_cart_items/:id", to: "cart#add_cart_items"

  get "/order/max_qty_ordered_food", to: "order#max_qty_ordered_food"
  get "/order/recent_orders", to: "order#recent_orders"
  get "/order/weekly_best", to: "order#weekly_best"
  get "/cart/:id/order", to: "order#make_order"
  delete "/cart_items/delete", to: "cart#delete"
  put "/cart/update", to: "cart#update"

  put "/user/update/:id", to: "user#update"
  put "/menu/update/:id", to: "menu#update"

  get "/menu/display_city_menu", to: "menu#display_city_menu"

  get "/admin/daily_revenue", to: "admin#daily_revenue"
  get "/admin/weekly_revenue", to: "admin#weekly_revenue"

  get "/users/signup", to: "user#new"
  post "/users/signup", to: "user#create"
  get "/customer_dashboard/:id", to: "dashboard#customer_dashboard", as: "customer_dashboard"
  get "/owner_dashboard", to: "dashboard#owner_dashboard", as: "owner_dashboard"
  get "/admin_dashboard", to: "dashboard#admin_dashboard", as: "admin_dashboard"
  get "/customer_dashboard/:id/about", to: "dashboard#about", as: "about"

  get "/login", to: "user#get_login"
  post "/login", to: "user#login"

  resources :user
  resources :restaurant_detail
  resources :menu
  resources :cart
  resources :order
  resources :state
  resources :city
  resources :rating
  resources :customer_dashboard
end
