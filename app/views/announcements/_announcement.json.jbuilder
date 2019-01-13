json.extract! announcement, :id, :text, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)