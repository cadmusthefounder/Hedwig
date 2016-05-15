require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @yihang = users(:yihang)
    @yihangs_session = sessions(:yihangs_session)

    @other = users(:other)
  end

  test "should get update_profile if logged in" do
    cookies[:remember_token] = @yihangs_session.remember_token
    get update_profile_path
    assert_response :success
  end

  test "should not get update_profile if not logged in" do
    get update_profile_path
    assert_redirected_to new_session_path
  end

  test "should patch/put update_profile if logged in" do
    cookies[:remember_token] = @yihangs_session.remember_token

    patch update_profile_path, params: { user: { name: "bla" } }
    assert_response :success
    @yihang.reload
    assert_equal "bla", @yihang.name

    put update_profile_path, params: { user: { name: "foobar" } }
    assert_response :success
    @yihang.reload
    assert_equal "foobar", @yihang.name
  end

  test "should not patch update_profile if not logged in" do
    patch update_profile_path, params: { user: { name: "bla" } }
    assert_redirected_to new_session_path
  end

  test "update_profile should ignore all fields except name" do
    cookies[:remember_token] = @yihangs_session.remember_token

    patch update_profile_path, params: { user: { id: @other.id, name: "santa" } }
    @other.reload
    assert_not_equal "santa", @other.name

    patch update_profile_path, params: { user: { email: "notyihang@example.com" } }
    @yihang.reload
    assert_not_equal "notyihang@example.com", @yihang.name

    patch update_profile_path, params: { user: { account_kit_id: "haha" } }
    @yihang.reload
    assert_not_equal "haha", @yihang.account_kit_id
  end
end
