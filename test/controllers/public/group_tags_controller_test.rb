require "test_helper"

class Public::GroupTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_group_tags_show_url
    assert_response :success
  end
end
