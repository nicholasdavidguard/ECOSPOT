json.extract! spot, :id, :name, :location, :likes, :dislikes, :description, :created_at, :updated_at
json.url spot_url(spot, format: :json)
