json.extract! reply, :id, :replyText, :Comments_id, :Users_id, :created_at, :updated_at
json.url reply_url(reply, format: :json)
