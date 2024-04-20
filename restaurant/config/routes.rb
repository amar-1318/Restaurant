Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post "/user/login", to: "user#login"
  get "/restaurant_detail/max_rating", to: "restaurant_detail#max_avg_rating"
  get "/menu/item_type", to: "menu#display_types"

  get "/cart/pending_cart", to: "cart#pending_cart_worth_1000"
  post "/:id/cart_items", to: "cart#add_cart_items"
  
  get "/order/max_qty_ordered_food", to: "order#max_qty_ordered_food"
  get "/order/recent_orders", to: "order#recent_orders"
  get "/order/weekly_best", to: "order#weekly_best"
  get "/cart/:id/order", to: "order#make_order"
  
  resources :user
  resources :restaurant_detail
  resources :menu
  resources :cart
  resources :order
  resources :state
  resources :city
  resources :rating
end
