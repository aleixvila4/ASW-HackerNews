 Rails.application.routes.draw do
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
  get 'contributions_CommentsIndex', to: 'contributions#indexComments'
  
  delete 'delete_vote', to: 'votes#destroy'
  post 'new_user', to: 'users#new'
  root 'contributions#index'
end
