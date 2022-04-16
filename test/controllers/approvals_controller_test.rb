require 'test_helper'

class ApprovalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get approvals_new_url
    assert_response :success
  end

  test "should get create" do
    get approvals_create_url
    assert_response :success
  end

  test "should get destroy" do
    get approvals_destroy_url
    assert_response :success
  end

end
