require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user    = users(:yihang)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    # Stub AccountKit
    stub(AccountKit).access_token { "abc123" }
    stub(AccountKit).me { {"email" => {"address" => @user.email},
                           "id"    => @user.account_kit_id} }

    # Submit POST request
    post sessions_url, params: {code: "myawesomecode"}

    # Expect the user to be logged in
    assert_response :success
    assert_not_nil cookies["remember_token"]
    session = Session.find_by(remember_token: cookies["remember_token"])
    assert_not_nil session
    assert_equal @user, session.user
  end
end
