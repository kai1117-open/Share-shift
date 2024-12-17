require "test_helper"

class Public::ShiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_shifts_index_url
    assert_response :success
  end

  test "should get show" do
    get public_shifts_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_shifts_edit_url
    assert_response :success
  end
end
