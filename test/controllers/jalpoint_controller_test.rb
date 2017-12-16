require 'test_helper'

class JalpointControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jalpoint_index_url
    assert_response :success
  end

end
