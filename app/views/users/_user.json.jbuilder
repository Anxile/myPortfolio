json.extract! user, :id, :make, :name, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
