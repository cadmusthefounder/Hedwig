require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  fixtures :all

  it "should get new" do
    get :new
    expect(response).to be_success
  end

  it "should create session" do
    @user = users(:yihang)

    AccountKit = double()
    allow(AccountKit).to receive(:access_token) { "abc123" }
    allow(AccountKit).to receive(:me) { {"email" => {"address" => @user.email},
                                         "id"    => @user.account_kit_id} }

    post :create, params: {code: "myawesomecode"}

    expect(response).to be_success
    expect(cookies[:remember_token]).not_to be_nil
    session = Session.find_by(remember_token: cookies["remember_token"])
    expect(session).not_to be_nil
    expect(session.user).to eq @user
  end
end
