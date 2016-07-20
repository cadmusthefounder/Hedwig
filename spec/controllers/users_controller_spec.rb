require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    @yihang = users(:yihang)
    @yihangs_session = sessions(:yihangs_session)

    @other = users(:other)
  end

  it "should get update_profile if logged in" do
    cookies[:remember_token] = @yihangs_session.remember_token
    get :edit
    expect(response).to be_success
  end

  it "should not get update_profile if not logged in" do
    get :edit
    expect(response).to redirect_to(new_session_path)
  end

  it "should patch/put update_profile if logged in" do
    cookies[:remember_token] = @yihangs_session.remember_token

    patch :update, params: { user: { name: "bla" } }
    expect(response).to redirect_to(root_path)
    @yihang.reload
    expect(@yihang.name).to eq "bla"

    put :update, params: { user: { name: "foobar" } }
    expect(response).to redirect_to(root_path)
    @yihang.reload
    expect(@yihang.name).to eq "foobar"
  end

  it "should not patch update_profile if not logged in" do
    patch :update, params: { user: { name: "bla" } }
    expect(response).to redirect_to(new_session_path)
  end

  it "update_profile should ignore all fields except name" do
    cookies[:remember_token] = @yihangs_session.remember_token

    patch :update, params: { user: { id: @other.id, name: "santa" } }
    @other.reload
    expect(@other.name).not_to eq "santa"

    patch :update, params: { user: { email: "notyihang@example.com" } }
    @yihang.reload
    expect(@yihang.email).not_to eq "notyihang@example.com"

    patch :update, params: { user: { account_kit_id: "haha" } }
    @yihang.reload
    expect(@yihang.account_kit_id).not_to eq "haha"
  end
end
