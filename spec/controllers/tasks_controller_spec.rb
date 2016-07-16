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

  it "should post create and be prompted to login if user is not logged in" do
    cookies.delete(:remember_token)
    post :create, params: {task: {from_address: "foobar"}}
    expect(response).to redirect_to new_session_path
  end

  it "should get show" do
    task = tasks(:first_task)
    get :show, params: {id: task.id}
    expect(response).to be_success
    expect(response).to render_template :show
  end

  it "should render home page if user is not logged in and is accessing index" do
    cookies.delete(:remember_token)
    get :index
    expect(response).to render_template 'static_pages/home'
  end

  describe "assign" do
    it "should reject if user is not the owner" do
      other_task = tasks(:second_task)
      another_user = users(:another)
      post :assign, params: {id: other_task.id, user_id: another_user.id}
      other_task.reload
      expect(other_task).to be_brand_new
    end

    it "should reject if user is assigning to herself" do
      user = users(:yihang)
      task = tasks(:first_task)
      post :assign, params: {id: task.id, user_id: user.id}
      task.reload
      expect(task).to be_brand_new
    end

    it "should reject if assignee is not interested" do
      user = users(:yihang)
      assignee = users(:other)
      task = tasks(:first_task)
      interest = task.interests.find_by(user: assignee)
      expect(interest).to be_nil # Ensure that assignee is not interested
      post :assign, params: {id: task.id, user_id: assignee.id}
      task.reload
      expect(task).to be_brand_new
    end

    it "should assign to the user otherwise" do
      user = users(:yihang)
      assignee = users(:other)
      task = tasks(:first_task)
      task.interests.create(user: assignee)
      interest = task.interests.find_by(user: assignee)
      expect(interest).not_to be_nil
      post :assign, params: {id: task.id, user_id: assignee.id}
      task.reload
      expect(task).to be_assigned
      expect(task.assigned_user).to eq assignee
    end
  end
end
