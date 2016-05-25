require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  it "should get home" do
    get :home
    expect(response).to have_http_status(:success)
  end

  it "should get about" do
    get :about
    expect(response).to have_http_status(:success)
  end


  it "should get FAQ" do
    get :faq
    expect(response).to have_http_status(:success)
  end

  it "should get terms of use" do
    get :terms_of_use
    expect(response).to have_http_status(:success)
  end

  it "should get privacy policy" do
    get :privacy_policy
    expect(response).to have_http_status(:success)
  end

end
