class QuotesTest < ActionDispatch::IntegrationTest
  require 'w3c_validators'
  include W3CValidators

  test 'unauthenticated user should not see unapproved quote submitted by another user' do
    q = Quote.new(text: 'this is a unique quote guaranteed not to be in any fixtures')
    q.save
    ["/quotes/#{q.id}", "/quotes/#{q.id}.json", '/bottom.json', '/latest.json', '/random.json', '/random1.json', '/top.json'].each do |endpoint|
      get endpoint
      assert_no_match(/this is a unique quote guaranteed not to be in any fixtures/, response.body, "Failure: found unapproved quote at #{endpoint}")
      assert_match(/Quote ##{q.id} is pending approval\./, response.body) unless endpoint =~ /json/
    end
  end

  test 'authenticated user should see unapproved quote submitted by any user' do
    q = Quote.new(text: 'this is a unique quote guaranteed not to be in any fixtures')
    q.save
    sign_in users(:one)    
    get "/quotes/#{q.id}"
    assert_no_match(/Quote ##{q.id} is pending approval\./, response.parsed_body)
    assert_match(/this is a unique quote guaranteed not to be in any fixtures/, response.parsed_body)
  end

  test 'unauthenticated user should see their own submitted unapproved quote' do
    q = Quote.new(text: 'this is a unique quote guaranteed not to be in any fixtures', submitterip: '127.0.0.1')
    q.save
    get "/quotes/#{q.id}"
    assert_no_match(/Quote ##{q.id} is pending approval\./, response.parsed_body)
    assert_match(/this is a unique quote guaranteed not to be in any fixtures/, response.parsed_body)
  end

  test 'it should make available a valid RSS feed displaying latest quotes' do
    get '/latest.rss'
    @validator = FeedValidator.new
    results = @validator.validate_text(response.body)

    if results.errors.length > 0
      results.errors.each do |err|
        puts err.to_s
        puts response.body
      end
    end

    assert_equal(results.errors.length, 0)

    expected_quotes = Quote.where(approved: true).order('id DESC').limit(5).each do |quote|
      assert_match(/#{quote.text}/, response.parsed_body)
    end

  end
end