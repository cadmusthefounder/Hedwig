require 'rails_helper'

RSpec.describe Session, :type => :model do
  fixtures :all
  
  it "remember_token should be unique" do
    @session = sessions(:yihangs_session)
    another_session = @session.user.sessions.build(remember_token: @session.remember_token)

    expect(another_session).not_to be_valid
  end
end
