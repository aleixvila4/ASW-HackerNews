 Rails.application.routes.draw do
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
  
  root 'contributions#index'
end
