require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  test "remember_token should be unique" do
    @session = sessions(:yihangs_session)
    another_session = @session.user.sessions.build(remember_token: @session.remember_token)

    refute another_session.valid?
  end
end
