 Rails.application.routes.draw do
  resources :comment_votes
  resources :comments
  resources :users
  resources :votes
  resources :contributions do
   member do
      put 'points'
    end
 end
  get 'contributions_NewIndex', to: 'contributions#indexNew'
  get 'contributions_AskIndex', to: 'contributions#indexAsk'
  get 'contributions_UserIndex', to: 'contributions#indexUserContributions'
  get 'contributions_CommentsIndex', to: 'contributions#indexComments'
  
  get 'vote_new', to: 'votes#create'
  get 'delete_vote', to: 'votes#destroy'
  
  post 'new_user', to: 'users#new'
  get 'edit_user', to: 'users#edit_user'
  
  get 'comment_new', to: 'comments#create'
  
  get 'comment_vote_new', to: 'comment_votes#create'
  
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get 'logout', to: 'sessions#logout'
  root 'contributions#index'
end
