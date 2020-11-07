 Rails.application.routes.draw do
  resources :contributions do
   member do
      put 'points'
    end
 end
  get 'contributions_NewIndex', to: 'contributions#indexNew'
  get 'contributions_CommentsIndex', to: 'contributions#indexComments'
  root 'contributions#index'
end
