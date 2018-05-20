<<<<<<< HEAD
json.extract! quote, :id, :text, :score, :created_at, :updated_at
=======
json.extract! quote, :id, :text, :score, :created_at, :updated_at, :approved, :flagged
>>>>>>> admin
json.url quote_url(quote, format: :json)
