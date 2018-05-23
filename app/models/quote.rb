class Quote < ApplicationRecord
  has_many :votes

  def score
    votes = Vote.where(quote: self)
    tally = votes.sum(:value)
    tally
  end
end
