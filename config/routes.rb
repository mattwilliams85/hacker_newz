Rails.application.routes.draw do

  root :to => 'links#index'

  resources :url

end
