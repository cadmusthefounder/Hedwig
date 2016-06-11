require 'rails_helper'
require 'will_paginate/array'

describe "tasks/index", :type => :view do
  it "should paginate" do
    tasks = (0..49).map { |i| tasks(:"task_#{i}") }
    assign(:tasks, tasks.paginate(page: 1))

    render

    expect(rendered).to have_selector("div.pagination")
  end

end
