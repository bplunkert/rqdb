require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  setup do
    @quote = quotes(:one)
  end

  test 'score' do
    assert_equal(5, @quote.score)
  end
end
