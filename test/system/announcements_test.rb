require "application_system_test_case"

class AnnouncementsTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:one)
  end

  test 'visiting the index' do
    visit '/'
    assert_select "pre", {:class => "announcement", :count=>1}
  end
end