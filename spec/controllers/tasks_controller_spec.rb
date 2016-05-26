require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  it "should get new" do
    get :new
    expect(response).to be_success
  end

  it "should get show" do
    task = tasks(:first_task)
    get :show, params: {id: task.id}
    expect(response).to be_success
    expect(response).to render_template :show
  end
end
