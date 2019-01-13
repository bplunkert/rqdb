if quote.approved == true or user_signed_in? or quote.submitterip == request.ip
  json.extract! quote, :id, :text, :score, :created_at, :updated_at, :approved, :flagged
else
  json.extract! quote, :id, :score, :created_at, :updated_at, :approved, :flagged
end

json.url quote_url(quote, format: :json)