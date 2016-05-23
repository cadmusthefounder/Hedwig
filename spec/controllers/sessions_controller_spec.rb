require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  before(:each) do
    @original_account_kit = AccountKit
  end

  after(:each) do
    AccountKit = @original_account_kit
  end

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
    expect(response).not_to redirect_to(update_profile_path)
    expect(cookies[:remember_token]).not_to be_nil
    session = Session.find_by(remember_token: cookies["remember_token"])
    expect(session).not_to be_nil
    expect(session.user).to eq @user
  end

  it "should create session and redirect new user to update profile" do
    AccountKit = double()
    allow(AccountKit).to receive(:access_token) { "abc123" }
    allow(AccountKit).to receive(:me) { {"email" => {"address" => "newuser@example.com"},
                                         "id"    => "newuser"} }

    post :create, params: {code: "myawesomecode"}

    expect(response).to redirect_to(update_profile_path)
  end
end
