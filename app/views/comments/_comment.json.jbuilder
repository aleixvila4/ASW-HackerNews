json.extract! comment, :id, :commentText, :contributions_id, :users_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
