json.extract! accomplishment, :id, :description, :accomplishment_type_id, :url, :bookmarked, :created_at, :updated_at
json.url accomplishment_url(accomplishment, format: :json)
