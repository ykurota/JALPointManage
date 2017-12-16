require 'test_helper'

class FlightclassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flightclass = flightclasses(:one)
  end

  test "should get index" do
    get flightclasses_url
    assert_response :success
  end

  test "should get new" do
    get new_flightclass_url
    assert_response :success
  end

  test "should create flightclass" do
    assert_difference('Flightclass.count') do
      post flightclasses_url, params: { flightclass: { addon: @flightclass.addon, classcode: @flightclass.classcode, flightclass: @flightclass.flightclass } }
    end

    assert_redirected_to flightclass_url(Flightclass.last)
  end

  test "should show flightclass" do
    get flightclass_url(@flightclass)
    assert_response :success
  end

  test "should get edit" do
    get edit_flightclass_url(@flightclass)
    assert_response :success
  end

  test "should update flightclass" do
    patch flightclass_url(@flightclass), params: { flightclass: { addon: @flightclass.addon, classcode: @flightclass.classcode, flightclass: @flightclass.flightclass } }
    assert_redirected_to flightclass_url(@flightclass)
  end

  test "should destroy flightclass" do
    assert_difference('Flightclass.count', -1) do
      delete flightclass_url(@flightclass)
    end

    assert_redirected_to flightclasses_url
  end
end
