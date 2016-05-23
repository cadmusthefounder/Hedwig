require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
  render_views

  describe "GET Home" do
    before(:each) do
      get :home
    end

    it "should get home" do
      expect(response).to have_http_status(:success)
    end
##
  #  it "should have correct title" do
   #   response.should have_selector("title", content: "Home | Hedwig")
  #  end
##
  end

end
