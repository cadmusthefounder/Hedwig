require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  before(:each) do
    @yihangs_session = sessions(:yihangs_session)
    cookies[:remember_token] = @yihangs_session.remember_token
  end

  it "should get new" do
    get :new
    expect(response).to be_success
  end

  it "should post create when all the required params are present" do
    task_params = {from_address: "123 Main Rd", from_postal_code: "123456",
                   to_address: "456 Main Rd", to_postal_code: "123456",
                   price: 1.23}
    expect { post :create, params: {task: task_params} }.to change { Task.count }.by(1)
    expect(response).to be_success
    expect(response).to render_template :show
  end

  it "should post create with errors when some of the params are missing" do
    task_params = {from_address: "foobar"}
    expect { post :create, params: {task: task_params} }.not_to change { Task.count }
    expect(response).to be_success
    expect(response).to render_template :new
  end

  it "should get show" do
    task = tasks(:first_task)
    get :show, params: {id: task.id}
    expect(response).to be_success
    expect(response).to render_template :show
  end

  it "should render home page if user is not logged in and is accessing index" do
    cookies[:remember_token] = nil
    get :index
    expect(response).to render_template 'static_pages/home'
  end

  it "should post express_interest" do
    user = users(:yihang)
    task = tasks(:second_task)
    post :express_interest, params: {id: task.id}
    expect(response).to redirect_to tasks_path
    expect(task.interested_users).to include user
    expect(user.interested_tasks).to include task
  end

  it "should post express_interest, but will not create duplicate interests" do
    user = users(:yihang)
    task = tasks(:second_task)
    user.interested_tasks << task

    expect { post :express_interest, params: {id: task.id} }.not_to change { task.interested_users.count }
  end

  it "should post express_interest, but will not mark owner as interested" do
    user = users(:yihang)
    task = tasks(:first_task)

    expect(task.user).to eq user

    expect { post :express_interest, params: {id: task.id} }.not_to change { task.interested_users.count }
  end
end
