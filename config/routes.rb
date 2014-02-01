Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :cinelists


  authenticated :user do
    root :to => 'home#index'
    post "films", :to => 'home#films', as: :films
    post "results", :to => 'home#film_results', as: :results
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end