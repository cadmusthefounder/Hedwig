require 'rails_helper'
require 'will_paginate/array'

describe "tasks/index", :type => :view do
  it "should paginate" do
    tasks = (0..49).map { |i| tasks(:"task_#{i}") }
    assign(:tasks, tasks.paginate(page: 1))

    render

    expect(rendered).to have_selector("div.pagination")
  end

  it "should show the express interest button to currently uninterested users" do
    task = tasks(:second_task)
    user = users(:yihang)

    assign(:current_user, user)
    assign(:tasks, [task].paginate(page: 1))

    render

    expect(rendered).to have_link("Express Interest")
  end

  it "should not show the express interest button to currently interested users" do
    task = tasks(:second_task)
    user = users(:yihang)
    task.interested_users << user

    assign(:current_user, user)
    assign(:tasks, [task].paginate(page: 1))

    render

    expect(rendered).not_to have_link("Express Interest")
  end

  it "should not show the express interest button to the owner" do
    task = tasks(:first_task)
    user = users(:yihang)

    assign(:current_user, user)
    assign(:tasks, [task].paginate(page: 1))

    render

    expect(rendered).not_to have_link("Express Interest")
  end
end
