require 'test_helper'

class FavoriteGuildsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_guilds_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_guilds_destroy_url
    assert_response :success
  end

end
