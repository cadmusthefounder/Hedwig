require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

  it "should get new task" do
    get :new
    expect(response).to have_http_status(:success)
  end

end

