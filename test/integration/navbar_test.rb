require 'test_helper'

class NavbarTest < ActionDispatch::IntegrationTest
  test 'the navbar should display the current version' do
    get '/'
    assert_match(/RQDB Version: #{Rails.configuration.version}/, response.parsed_body)
  end

  test 'the navbar should display the total number of approved and submitted quotes' do
    get '/'
    assert_match(/#{Quote.where(approved: false).count} quotes submitted; #{Quote.where(approved: true).count} quotes approved/, response.parsed_body)    
  end
end