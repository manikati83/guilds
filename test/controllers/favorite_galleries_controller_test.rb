require 'test_helper'

class FavoriteGalleriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_galleries_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_galleries_destroy_url
    assert_response :success
  end

end
