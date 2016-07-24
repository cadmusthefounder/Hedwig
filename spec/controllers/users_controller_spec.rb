require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    @yihang = users(:yihang)
    @yihangs_session = sessions(:yihangs_session)
    @other = users(:other)
  end

  it "should get update_profile if logged in" do
    cookies[:remember_token] = @yihangs_session.remember_token
    get :edit, params: {id: @yihang.id}
    expect(response).to be_success
  end

  it "should not get update_profile if not logged in" do
    get :edit, params: {id: @yihang.id}
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
    patch :update, id: @yihang.id, params: { user: { name: "bla" } }
    expect(response).to redirect_to(new_session_path)
  end

end
