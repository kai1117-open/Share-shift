require "test_helper"

class Admin::GroupTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_group_tags_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_group_tags_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_group_tags_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_group_tags_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_group_tags_destroy_url
    assert_response :success
  end
end
