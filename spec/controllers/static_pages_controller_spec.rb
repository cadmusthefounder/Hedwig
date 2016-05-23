require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
  describe "GET Home" do
    before(:each) do
      get :home
    end

    it "should get home" do
      expect(response).to have_http_status(:success)
    end
  end
end
