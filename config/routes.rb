MoviesBack2Back::Application.routes.draw do


  authenticated :user do
    root :to => 'home#index'
    post "films", :to => 'home#films', as: :films
    post "results", :to => 'home#film_results', as: :results
    post 'quickview', :to => 'home#favourites', as: :quickview
    #resources :cinelists
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end