require 'rails_helper'

describe "tasks/index", :type => :view do
  it "should paginate" do
    tasks = (0..49).map { |i| tasks(:"task_#{i}") }
    assign(:task, tasks)

    render

    expect(rendered).to have_selector("div.pagination")
  end

end

