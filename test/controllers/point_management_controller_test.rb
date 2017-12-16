require 'test_helper'

class PointManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get point_management_index_url
    assert_response :success
  end

end
