class Announcement < ApplicationRecord
  validates :text, presence: true
end
