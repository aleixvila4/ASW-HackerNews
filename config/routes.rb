 Rails.application.routes.draw do
  resources :contributions do
   member do
      put 'points'
    end
 end
  get 'contributions_NewIndex', to: 'contributions#indexNew'
  get 'contributions_AskIndex', to: 'contributions#indexAsk'
  get 'contributions_CommentsIndex', to: 'contributions#indexComments'
  delete 'destroy_points_contribution' => 'contributions#destroyVote'
  root 'contributions#index'
end
