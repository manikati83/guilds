require 'test_helper'

class GuildNewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get guild_news_new_url
    assert_response :success
  end

  test "should get create" do
    get guild_news_create_url
    assert_response :success
  end

  test "should get destroy" do
    get guild_news_destroy_url
    assert_response :success
  end

end
