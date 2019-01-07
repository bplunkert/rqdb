class QuotesTest < ActionDispatch::IntegrationTest
  test 'unauthenticated user should not see unapproved quote submitted by another user' do
    q = Quote.new(text: 'this is a unique quote guaranteed not to be in any fixtures')
    q.save
    get "/quotes/#{q.id}"
    assert_no_match(/this is a unique quote guaranteed not to be in any fixtures/, response.parsed_body)
    assert_match(/Quote ##{q.id} is pending approval\./, response.parsed_body)
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

end