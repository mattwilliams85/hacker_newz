Rails.application.routes.draw do

  root :to => 'links#index'
  resources :comments do
    resources :comments
  end
  resources :links do
    resources :comments
  end

  get '/link/:id/comment', to: 'comments#create2', as: 'nested_comment'

end
