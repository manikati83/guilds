require 'test_helper'

class QuestMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get quest_messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get quest_messages_destroy_url
    assert_response :success
  end

end
