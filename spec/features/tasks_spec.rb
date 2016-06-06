require 'rails_helper'

describe "Tasks" do
#  before(:each) do
 #   @yihangs_session = sessions(:yihangs_session)
  #  cookies[:remember_token] = @yihangs_session.remember_token
  #end

  it "should paginate" do
    visit all_tasks_path
    expect(page).to have_selector("div.selector")
  end
end
