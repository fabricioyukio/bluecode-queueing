Rails.application.routes.draw do
  resources :urls
  # get 'auctions/index'
  # get 'auctions/show'
  # get 'auctions/create'
  # get 'auctions/update'
  resources :auctions, only: %i[index show create destroy update]
  
  resources :urls, only: %i[index create]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
