require "test_helper"

class BlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get blogs_show_url
    assert_response :success
  end
end
