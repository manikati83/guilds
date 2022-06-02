require 'test_helper'

class QuestMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get quest_members_create_url
    assert_response :success
  end

  test "should get destroy" do
    get quest_members_destroy_url
    assert_response :success
  end

end
