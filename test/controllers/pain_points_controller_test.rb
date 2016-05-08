require 'test_helper'

class PainPointsControllerTest < ActionController::TestCase
  setup do
    @pain_point = pain_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pain_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pain_point" do
    assert_difference('PainPoint.count') do
      post :create, pain_point: { location_id: @pain_point.location_id, magnitude: @pain_point.magnitude, notes: @pain_point.notes, user_id: @pain_point.user_id }
    end

    assert_redirected_to pain_point_path(assigns(:pain_point))
  end

  test "should show pain_point" do
    get :show, id: @pain_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pain_point
    assert_response :success
  end

  test "should update pain_point" do
    patch :update, id: @pain_point, pain_point: { location_id: @pain_point.location_id, magnitude: @pain_point.magnitude, notes: @pain_point.notes, user_id: @pain_point.user_id }
    assert_redirected_to pain_point_path(assigns(:pain_point))
  end

  test "should destroy pain_point" do
    assert_difference('PainPoint.count', -1) do
      delete :destroy, id: @pain_point
    end

    assert_redirected_to pain_points_path
  end
end
