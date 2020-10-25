json.extract! contribution, :id, :title, :author, :url, :text, :created_at, :updated_at
json.url contribution_url(contribution, format: :json)
