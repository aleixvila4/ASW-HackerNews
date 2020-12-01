 Rails.application.routes.draw do
  resources :reply_votes
  resources :replies
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
  
  get 'vote_new', to: 'votes#create'
  get 'delete_vote', to: 'votes#destroy'
  
  post 'new_user', to: 'users#new'
  
  get 'show_user', to: 'users#show'
  get 'edit_user', to: 'users#edit_user'
  get 'user_contributions_Index', to: 'contributions#index_user_contributions'
  get 'user_voted_contributions_Index', to: 'contributions#index_voted_user_contributions'
  
  get 'comment_new', to: 'comments#create'
  get 'comment_vote_new', to: 'comment_votes#create'
  get 'comment_Threads', to: 'comments#indexThreads'
  get 'user_comments_Index', to: 'comments#index_user_comments'
  get 'user_voted_comments_Index', to: 'comments#index_voted_user_comments'
  
  get 'reply_vote_new', to: 'reply_votes#create'
  
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get 'logout', to: 'sessions#logout'
  get 'form_edit', to: 'contributions#edit'
  
  get 'api/contributions', to: 'contribution_api#indexAPI'
  get 'api/contributions/newest', to: 'contribution_api#indexNewAPI'
  get 'api/contributions/ask', to: 'contribution_api#indexAskAPI'
  get 'api/contributions/comments/:id', to: 'contribution_api#index_comments_contributions'
  post 'api/contributions/new', to: 'contribution_api#createContributionAPI'
  
  get 'api/comments/replies/:id', to: 'comments_api#index_replies_comments'
  
  root 'contributions#index'
end
