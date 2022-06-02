require 'test_helper'

class FavoriteBlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_blogs_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_blogs_destroy_url
    assert_response :success
  end

end
