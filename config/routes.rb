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
  
  get 'api/contributions', to: 'contributions_api#indexAPI'
  get 'api/contributions/newest', to: 'contributions_api#indexNewAPI'
  get 'api/contributions/ask', to: 'contributions_api#indexAskAPI'
  get 'api/contributions/comments/:id', to: 'contributions_api#index_comments_contributionsAPI'
  post 'api/contributions/new', to: 'contributions_api#createContributionAPI'
  get 'api/contributions/:id', to: 'contributions_api#show_contributionAPI'
  post 'api/contributions/:id', to: 'comments_api#createCommentAPI'
  put 'api/contributions/:id', to: 'contributions_api#updateContributionAPI'
  delete 'api/contributions/:id', to: 'contributions_api#destroyContributionAPI'
  post 'api/contributions/:id/vote', to: 'votes_api#createContributionVoteAPI'
  delete 'api/contributions/:id/vote', to: 'votes_api#destroyContributionVoteAPI'
  
  get 'api/comments/:id', to: 'comments_api#show_commentAPI'
  get 'api/threads', to: 'comments_api#indexThreadsAPI'
  post 'api/comments/:id', to: 'replies_api#createReplyAPI'
  put 'api/comments/:id', to: 'comments_api#updateCommentAPI'
  delete 'api/comments/:id', to: 'comments_api#destroyCommentAPI'
  get 'api/comments/replies/:id', to: 'comments_api#index_replies_comments'
  post 'api/comments/:id/vote', to: 'comment_votes_api#createCommentVoteAPI'
  delete 'api/comments/:id/vote', to: 'comment_votes_api#destroyCommentVoteAPI'
  
  get 'api/replies/:id', to: 'replies_api#show_replyAPI'
  put 'api/replies/:id', to: 'replies_api#updateReplyAPI'
  delete 'api/replies/:id', to: 'replies_api#destroyReplyAPI'
  post 'api/replies/:id/vote', to: 'reply_votes_api#createReplyVoteAPI'
  delete 'api/replies/:id/vote', to: 'reply_votes_api#destroyReplyVoteAPI'
  
  get 'api/users/info/:username', to: 'users_api#showUserUsernameAPI'
  get 'api/users/:id', to: 'users_api#showUserIDAPI'
  put 'api/users/:id', to: 'users_api#updateUserAPI'
  get 'api/users/:id/contributions', to: 'contributions_api#index_user_contributionsAPI'
  get 'api/users/:id/comments', to: 'comments_api#index_user_commentsAPI'
  get 'api/users/:id/upvotedcontributions', to: 'votes_api#index_user_votedcontributionsAPI'
  get 'api/users/:id/upvotedcomments', to: 'comment_votes_api#index_user_votedcommentsAPI'
  
  root 'contributions#index'
end
