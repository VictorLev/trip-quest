require "test_helper"

class PlannedRoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get planned_routes_show_url
    assert_response :success
  end
end
