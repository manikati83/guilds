require 'test_helper'

class GuildMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get guild_members_create_url
    assert_response :success
  end

  test "should get destroy" do
    get guild_members_destroy_url
    assert_response :success
  end

end
