class Chatbot < ApplicationRecord
  validates :app, format: { with: /(Discord|Slack)/ }
end